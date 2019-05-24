class AddColumnsToRentals < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :title, :string
    add_column :rentals, :name, :string
    add_column :rentals, :postal_code, :string
  end
end
