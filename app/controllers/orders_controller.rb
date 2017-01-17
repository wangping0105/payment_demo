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
    _new_account = @account.amount - @order.price
    Order.transaction do
      if _new_account >= 0
        flash[:success] = "支付成功!"
        @order.status = Order.statuses[:paid]
        @account.amount= _new_account
        @order.save
        @account.save
      else
        flash[:error] = "支付失败, 余额不足!"
        @order.status = Order.statuses[:failed]
        @order.save
      end
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
