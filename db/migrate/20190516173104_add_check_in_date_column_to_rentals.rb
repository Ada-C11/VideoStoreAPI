class AddCheckInDateColumnToRentals < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :checkin_date, :datetime
  end
end
