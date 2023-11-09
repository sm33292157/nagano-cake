class Public::OrdersController < ApplicationController
  
  def new
    ##@address = Address.new
    @order = Order.new
    @addresses = current_customer.addresses.all
  end
  
  def confirm
    @order = Order.new
    
    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_cutomer.last_name + current_customer.first_name
    end
  end
  
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
  end
  
  def index
  end
  
  def thanks
  end
  
  def show
  end
  
  private
  
  def order_params
    params.require(:order).permit(:address, :name, :postal_code, :shipping_fee, :payment_method, :payment_amount, :order_status, :customer_id)
  end
end
