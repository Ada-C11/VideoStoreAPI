class AddCheckedinColumnRentals < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :checked_in_date, :date
  end
end
