class AddDefaultDueDateValueToRental < ActiveRecord::Migration[5.2]
  def change
    change_column :rentals, :due_date, :date, default: Date.today + 7
  end
end
