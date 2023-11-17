class Public::GenresController < ApplicationController
  
  def genre
    @genre_id = params[:genre_id]
    @items = Item.where(genre_id: @genre_id)
    @genres = Genre.all
  end
end
