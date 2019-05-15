class Changedefaultofavailableinventorytonil < ActiveRecord::Migration[5.2]
  def change
    change_column :movies, :available_inventory, :integer, :default => nil
  end
end
