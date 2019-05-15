class AddColumnsToRentals < ActiveRecord::Migration[5.2]
  def change
    add_column(:rentals, :checkout, :date)
    add_column(:rentals, :due_date, :date)
    add_column(:rentals, :status, :string)
  end
end
