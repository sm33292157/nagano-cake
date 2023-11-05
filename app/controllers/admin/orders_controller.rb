class Admin::OrdersController < ApplicationController
  
  def new
    @order = Order.new
    @addresses = current_customer.addresses.all
  end
  
  private
  
  def order_params
    params.require(:order).permit(:customer_id, :name, :address, :postal_code, :shipping_fee, :payment_method, :payment_amount, :order_status)
  end
end
