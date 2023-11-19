class HomesController < ApplicationController
  
  def top
    @items = Item.where(is_active: 1).page(params[:page]).per(4)
    @genres = Genre.all
  end

  def about
  end
end
