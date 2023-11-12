class Public::OrdersController < ApplicationController
  
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
      @shipping_address = Address.find(params[:order][:address_id])
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
      @ordered_item = OrderedItem.new
      @ordered_item.item_id = cart_item.item_id
      @ordered_item.amount = cart_item.amount
      @ordered_item.add_tax_price = (cart_item.price * 1.1).floor
      @ordered_item.order_id = @order.id
      @ordered_item.save
    end
    current_custoemr.cart_item.destroy_all
    redirect_to orders_thanks_path
  end
  
  def index
    @orders = current_customer.orders
  end
  
  def thanks
  end
  
  def show
    #@order = Order.find(params[:id])
    #@ordered_items = @order.ordered_items
  end
  
  private
  
  def order_params
    params.require(:order).permit(:address, :name, :postal_code, :shipping_fee, :payment_method, :payment_amount, :order_status, :customer_id)
  end
end
