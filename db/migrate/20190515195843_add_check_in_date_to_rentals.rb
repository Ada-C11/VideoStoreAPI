class AddCheckInDateToRentals < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :check_in_date, :date
  end
end
