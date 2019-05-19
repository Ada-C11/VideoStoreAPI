class AddCheckoutDuedateAndCheckintoRental < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :check_out, :date
    add_column :rentals, :due_date, :date
    add_column :rentals, :available, :boolean
  end
end
