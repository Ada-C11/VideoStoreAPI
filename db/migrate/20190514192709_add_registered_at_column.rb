class AddRegisteredAtColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :registered_at, :datetime
  end
end
