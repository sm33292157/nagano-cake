class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  #製作ステータス
  def update
    #注文詳細データを取得
    @order_detail = OrderDetail.find(params[:id])
    #注文詳細に紐づく注文データを取得
    @order = @order_detail.order
    #製作ステータスを更新
    if @order_detail.update(order_detail_params)
      #注文に紐づく注文詳細の製作ステータスが製作中になったら、注文ステータスを製作中にする
      if @order_detail.making_status == "production"
        @order.update(order_status: :making)
      #製作ステータスが全て製作完了になったら、注文ステータスを発送準備中にする
      elsif @order.order_details.count == @order.order_details.where(making_status: :complete).count
        @order.update(order_status: :in_preparation)
      end
    end
    redirect_to request.referer
  end
  
  private
  
  def order_detail_params
    params.require(:order_detail).permit(:making_status, :order_id)
  end
end
