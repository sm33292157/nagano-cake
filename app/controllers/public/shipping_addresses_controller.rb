class Public::ShippingAddressesController < ApplicationController
  
  def index
    @shipping_addresses = current_customer.shipping_addresses
    @shipping_address = ShippingAddress.new
  end
  
  def create
    @shipping_address = ShippingAddress.new(shipping_address_params)
    @shipping_address.customer_id = current_customer.id
    if @shipping_address.save
      flash[:notice] = "配送先を追加しました。"
      redirect_to shipping_addresses_path
    else
      @customer = current_customer
      @shipping_addresses = @customer.shipping_addresses.all
      render :index
    end
  end
  
  def edit
    @shipping_address = ShippingAddress.find(params[:id])
  end
  
  def update
    @shipping_address = ShippingAddress.find(params[:id])
    if @shipping_address.update(shipping_address_params)
      flash[:notice] = "配送先の情報を更新しました。"
      redirect_to shipping_addresses_path
    else
      render :edit
    end
  end
  
  def destroy
    @shipping_address = ShippingAddress.find(params[:id])
    if @shipping_address.destroy
      flash[:notice] = "配送先を１件削除しました。"
      redirect_to shipping_addresses_path
    else
      render :index
    end
  end
  
  private
  
  def shipping_address_params
    params.require(:shipping_address).permit(:name, :address, :postal_code, :customer_id)
  end
end
