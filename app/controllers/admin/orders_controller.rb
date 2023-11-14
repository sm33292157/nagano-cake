class Admin::OrdersController < ApplicationController
  
  def index
    @orders = Order.all
  end
  
  def show
    @order = Order.find(params[:id])
  end
  #注文ステータス
  def update
    #注文データを取得
    @order = Order.find(params[:id])
    #注文ステータスを更新
    if @order.update(order_params)
    #もし入金確認できたら、製作ステータスを製作待ちにする
      if @order.order_status == "payment_confirm"
        @order.order_details.update(making_status: :waiting)
      end
      redirect_to request.referer
    end
  end
  
  private
  
  def order_params
    params.require(:order).permit(:order_status)
  end
  
end
