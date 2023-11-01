class ShippingAddress < ApplicationRecord
  belongs_to :customer
  
  with_options presence: true do
    validates :customer_id
    validates :postal_code
    validates :address
    validates :name
  end
end
