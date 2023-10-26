class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :shipping_addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  
  # 漢字
  validates :last_name, presence: true, format: { with: /\A[一-龥]+\z/ }
  # 漢字
  validates :first_name, presence: true, format: { with: /\A[一-龥]+\z/ }
  # 全角カタカナ
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  # 全角カタカナ
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  # 郵便番号（ハイフンなし7桁）
  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }
  validates :address, presence: true
  # 携帯番号(ハイフンなし10桁or11桁)
  validates :telephone_number, presence: true, format: { with: /\A\d{10,11}\z/ }
end
