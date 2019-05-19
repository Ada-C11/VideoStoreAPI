class AddForeignKeysToRentals < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :rentals, :customers
    add_foreign_key :rentals, :movies
  end
end
