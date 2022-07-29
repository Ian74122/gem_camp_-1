class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(params_order)
    @order.user = current_user
    if @order.save
      # call merchant
      service = XxxPayDepositService.new
      data = service.deposit(@order)
      if data[:url].present?
        @order.submit!
        redirect_to data[:url]
      else
        @order.fail!
        flash[:alert] = "merchant create failed"
        redirect_to new_order_path
      end
    else
      render :new
    end
  end

  private

  def params_order
    params.require(:order).permit(:amount)
  end
end
