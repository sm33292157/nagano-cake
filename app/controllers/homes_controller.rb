class HomesController < ApplicationController
  
  def top
    @items = Item.all
    @genres = Genre.all
    @genre_id = params[:genre_id]
    @items = Item.where(genre_id: @genre_id)
  end

  def about
  end
end
