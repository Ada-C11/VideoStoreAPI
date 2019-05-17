class ChangeInventoryToInteger < ActiveRecord::Migration[5.2]
  def change
    change_column :movies, :inventory, 'integer USING CAST(inventory AS integer)'
  end
end
