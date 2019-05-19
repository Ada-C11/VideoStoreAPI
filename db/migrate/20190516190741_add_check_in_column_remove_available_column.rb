class AddCheckInColumnRemoveAvailableColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :check_in, :date
    remove_column :rentals, :available, :boolean
  end
end
