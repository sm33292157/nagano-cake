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
    if params[:id] == "withdraw" # idがwithdrawか否か判別する
      withdraw
    elsif @customer.update(customer_params)
      flash[:notice] = "会員情報を更新しました。"
      redirect_to customers_mypage_path(current_customer)
    else
      render :edit
    end
  end
  
  def withdraw_confirm
  end
  
  def withdraw
    @customer = current_customer
    if @customer.update(is_active: false) # 無効状態にする
      reset_session # ログアウト
    end
    flash[:notice] = "またのご利用をお待ちしております。"
    redirect_to root_path
  end

  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :is_active, :email)
  end
end