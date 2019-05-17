class AddReferencesToRentals < ActiveRecord::Migration[5.2]
  def change
    add_reference :rentals, :movie, index: true
    add_reference :rentals, :customer, index: true
  end
end
