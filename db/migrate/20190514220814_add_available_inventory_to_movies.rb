class AddAvailableInventoryToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :available_inventory, :integer
  end
end
