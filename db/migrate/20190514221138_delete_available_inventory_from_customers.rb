class DeleteAvailableInventoryFromCustomers < ActiveRecord::Migration[5.2]
  def change
    remove_column :customers, :available_inventory
  end
end
