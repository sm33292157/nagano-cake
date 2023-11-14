class Order < ApplicationRecord
  belongs_to :customer
  has_many :cart_items
  has_many :order_details
  enum payment_method: { credit_card: 0, transfer: 1 }
  
  enum order_status: { payment_wait: 0, payment_confirm: 1, making: 2, in_preparation: 3, shipped: 4 }
  
  def add_tax_price
    (price * 1.1).floor
  end
  
  def subtotal
    item.with_tax_price * amount
  end
end
