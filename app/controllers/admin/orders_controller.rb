class Admin::OrdersController < ApplicationController
  
  def index
    @orders = Order.all
  end
  
  def show
    @order = Order.find(params[:id])
  end
  #注文ステータス
  def update
    @order = Order.find(order_params)
    @order.update(order_params)
    if
    end
  end
  
  private
  
  def order_params
    params.require(:order).permit(:order_status)
  end
  
end
