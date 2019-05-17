class AddColumnsToMovie < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :title, :string
    add_column :movies, :overview, :string
    add_column :movies, :release_date, :date
    add_column :movies, :inventory, :integer
  end
end
