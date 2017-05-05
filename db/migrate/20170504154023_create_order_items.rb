class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.string :name
      t.string :price

      t.timestamps null: false
    end
  end
end
