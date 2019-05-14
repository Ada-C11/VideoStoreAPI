class ChangeCheckInCheckOutName < ActiveRecord::Migration[5.2]
  def change
    rename_column(:rentals, :check_out, :checkout_date)
    rename_column(:rentals, :check_in, :checkin_date)
  end
end
