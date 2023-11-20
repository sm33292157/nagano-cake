class Public::GenresController < ApplicationController
  before_action :authenticate_customer!
  
  def genre
    @genre_id = params[:genre_id]
    @items = Item.where(genre_id: @genre_id)
    @genres = Genre.all
  end
end
