class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
  
  with_options presence: true do
    validates :name
    validates :introduction
    validates :price
    validates :genre_id
    validates :image
  end
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/naganocake.logo.PNG')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [300, 300]).processed
  end
  
  def add_tax_price
  (self.price * 1.10).round
  end

end
