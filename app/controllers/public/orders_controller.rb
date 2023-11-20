class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  
  def new
    @order = Order.new
    @shipping_addresses = current_customer.shipping_addresses.all
  end
  
  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items.all
    @total = 0
    @order.shipping_fee = 800
    
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
      
    elsif params[:order][:select_address] == "1"
      @shipping_address = ShippingAddress.find(params[:order][:address_id])
      @order.postal_code = @shipping_address.postal_code
      @order.address = @shipping_address.address
      @order.name = @shipping_address.name
      
    elsif params[:order][:select_address] == "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
      
    else
      render 'new'
    end
  end
  
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    
    current_customer.cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.item_id = cart_item.item.id
      @order_details.amount = cart_item.amount
      @order_details.payment_amount = cart_item.item.with_tax_price
      @order_details.order_id = @order.id
      @order_details.save
    end
    current_customer.cart_items.destroy_all
    redirect_to orders_thanks_path
  end
  
  def index
    @orders = current_customer.orders.all
  end
  
  def thanks
  end
  
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end
  
  private
  
  def order_params
    params.require(:order).permit(:address, :name, :postal_code, :shipping_fee, :payment_method, :payment_amount, :order_status, :customer_id)
  end
end
