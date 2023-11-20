class Public::SearchesController < ApplicationController
  
  def search_form
    @content = params[:content]
    @records = Item.search_for(@content)
  end
end
