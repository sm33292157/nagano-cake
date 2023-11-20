class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @orders = Order.page(params[:page])
  end
  
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end
  
  def update #注文ステータス
    @order = Order.find(params[:id]) #注文データを取得
    @order_details = @order.order_details
    if @order.update(order_params)
      if @order.order_status == "payment_confirm" #注文ステータスが入金確認と完全一致すると
        @order_details.update_all(making_status: :waiting) #製作ステータスが製作待ちになる
      end
      redirect_to request.referer
    end
  end
  
  private
  
  def order_params
    params.require(:order).permit(:order_status)
  end
  
end
