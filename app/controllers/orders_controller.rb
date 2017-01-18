class OrdersController < ApplicationController
  before_action :set_commodity, only: [:new, :create]
  before_action :set_order, only: [:show, :pay, :pay_result]
  layout 'sessions', only:[ :pay_result]
  def index
  end

  def new

  end

  def create
    _total_price = params[:price].to_f * params[:count].to_f
    _no = "D#{Time.now.to_i}#{current_user.id}#{SecureRandom.random_number(0..999999).to_s.rjust(6, '0')}"
    @order = current_user.orders.build(origin_price: _total_price, commodity: @commodity, no: _no)
    if @order.save
      flash[:success] = "订单创建成功!"
      redirect_to order_path(@order)
    else
      render 'new'
    end
  end

  def show
    @commodity = @order.commodity
  end

  def pay
    @account = current_user.user_account
    Order.transaction do
      payment_code, message = PaymentCore.pay_money(amount: @order.price, user_acccount_id: @account.id)
      if PaymentCore.is_pay_success?(payment_code)
        flash[:success] = message
        @order.status = Order.statuses[:paid]
      else
        flash[:error] = message
        @order.status = Order.statuses[:failed]
      end
      @order.save
    end

    redirect_to pay_result_order_path(@order)
  end

  def pay_result
  end

  private
  def set_commodity
    @commodity = Commodity.find(params[:commodity_id])
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
