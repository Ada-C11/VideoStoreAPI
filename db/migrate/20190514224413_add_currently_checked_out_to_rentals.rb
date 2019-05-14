class AddCurrentlyCheckedOutToRentals < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :currently_checked_out, :boolean
  end
end
