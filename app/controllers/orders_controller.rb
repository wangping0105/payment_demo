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
    @order.status = Order.statuses[:paid]
    @account = current_user.user_account
    _new_account = @account.amount - @order.price
    if _new_account >= 0 && @order.save
      flash[:success] = "支付成功!"
      @account.amount= _new_account
      @account.save
      redirect_to pay_result_order_path(@order, flag: true)
    else
      flash[:error] = "支付失败#{",余额不足!" if _new_account < 0}"
      redirect_to pay_result_order_path(@order, flag: true)
    end
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
