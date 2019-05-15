class AddDueDateColumnToRentals < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :due_date, :datetime
  end
end
