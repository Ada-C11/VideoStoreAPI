class AddForeignKeysToRentals < ActiveRecord::Migration[5.2]
  def change
    add_reference :rentals, :movie, index: true, foreign_key: true
    add_reference :rentals, :customer, index: true, foreign_key: true
  end
end
