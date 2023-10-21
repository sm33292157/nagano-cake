class CreateItems < ActiveRecord::Migration[6.1]
  
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      t.integer :genre_id, null: false
      t.boolean :is_active, null: false, default: true
      t.timestamps
    end
    
    create_table :cart_items do |t|
      t.integer :item_id, nul: false
      t.integer :customer_id, null: false
      t.integer :amount, null: false
      t.timestamps
    end
    
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.string :name, null: false
      t.string :address, null: false
      t.string :postal_code, null: false
      t.integer :shipping_fee, null: false
      t.integer :payment_method, null: false
      t.integer :payment_amount, null: false
      t.integer :order_status, null: false, default: 0
      t.timestamps
    end
    
    create_table :order_details do |t|
      t.integer :item_id, null: false
      t.integer :order_id, null: false
      t.integer :amount, null: false
      t.integer :payment_amount, null: false
      t.integer :making_status, null: false, default: 0
      t.timestamps
    end
  
    create_table :shipping_addresses do |t|
      t.integer :customer_id, null: false
      t.string :name, null: false
      t.string :address, null: false
      t.string :postal_code, null: false
      t.timestamps
    end
    
    create_table :genres do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
  
end
