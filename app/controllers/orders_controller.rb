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
      # service = XxxPayService.new
      # serivee.depoist(order) -> if this one can get some data
      @order.submit!
      # if submit redirect the payment url
      # else
      # @order.fail!
    else
      render :new
    end
  end

  private

  def params_order
    params.require(:order).permit(:amount)
  end
end
