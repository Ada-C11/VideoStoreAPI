class AddAvailableInventoryToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column(:movies, :available_inventory, :integer)
  end

  reversible do |dir|
    dir.up {Movie.update_all('available_inventory = inventory')}
  end
end
