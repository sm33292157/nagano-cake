class Admin::OrderDetailsController < ApplicationController
  #製作ステータス
  def update
    #注文詳細データを取得
    @order_detail = OrderDetail.find(params[:id])
    #注文詳細に紐づく注文データを取得
    @order = order_detail.order
    #製作ステータスを更新
    if @order_detail.update(order_detail_params)
      #注文に紐づく注文詳細の製作ステータスが製作中になったら、注文ステータスを製作中にする
      if
      #製作ステータスが全て製作完了になったら、注文ステータスを発送準備中にする
      elsif
      end
    end
    redirect_to request.referer
  end
  
  private
  
  def order_detail_params
    params.require(:order_detail).permit(:maiking_status)
  end
end
