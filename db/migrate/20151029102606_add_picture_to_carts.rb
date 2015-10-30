class AddPictureToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :picture, :string
  end
end
