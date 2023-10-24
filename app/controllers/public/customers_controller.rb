class Public::CustomersController < ApplicationController
  
  def withdraw
    @customer = Customer.find(current_customer)
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "またのご利用をお待ちしております。"
    redirect_to root_path
  end
end
