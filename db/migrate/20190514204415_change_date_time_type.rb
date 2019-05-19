class ChangeDateTimeType < ActiveRecord::Migration[5.2]
  def change
    change_column :customers, :registered_at, :datetime
  end
end
