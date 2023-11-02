class Public::ItemsController < ApplicationController
  
  def index
    @items = Item.all
  end
  
  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
  
  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item.id)
    else
      render 'public/items/edit'
    end
  end
  
  private
  
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :genre_id, :image, :is_active)
  end
end
