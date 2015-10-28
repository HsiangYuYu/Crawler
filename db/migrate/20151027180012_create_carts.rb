class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.text :name
      t.integer :price

      t.timestamps null: false
    end
  end
end
