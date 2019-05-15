class RemoveDateAndDueDateFromRental < ActiveRecord::Migration[5.2]
  def change
    remove_column :rentals, :due_date
    remove_column :rentals, :date
  end
end
