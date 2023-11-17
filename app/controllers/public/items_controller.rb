class Public::ItemsController < ApplicationController
  
  def index
    @items = Item.all
    @genres = Genre.all
    @genre_id = params[:genre_id]
    @items = Item.where(genre_id: @genre_id)
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
  
  def genre
    @genre_id = params[:genre_id]
    @items = Item.where(genre_id: @genre_id)
    @genres = Genre.all
  end
  
  private
  
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :genre_id, :image, :is_active)
  end
end
