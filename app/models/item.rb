class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre_id
  
  with_options presence: true do
    validates :name
    validates :introduction
    validates :price
    validates :genre_id
    validates :image
  end
end
