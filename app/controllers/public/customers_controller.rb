class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  
  def show
    @customer = current_customer
  end
  
  def edit
    @customer = current_customer
  end
  
  def update
    @customer = current_customer
    if @customer.save
      redirect_to customers_mypage_path(current_customer)
    end
  end
  
  def withdraw
    @customer = Customer.find(current_customer)
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "またのご利用をお待ちしております。"
    redirect_to root_path
  end
end
