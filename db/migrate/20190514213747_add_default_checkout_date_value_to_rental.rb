class AddDefaultCheckoutDateValueToRental < ActiveRecord::Migration[5.2]
  def change
    change_column :rentals, :checkout_date, :date, default: Date.today
  end
end
