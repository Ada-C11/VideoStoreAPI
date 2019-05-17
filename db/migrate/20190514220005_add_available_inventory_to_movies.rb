class AddAvailableInventoryToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :available_inventory, :integer

    Movie.find_each do |movie|
      movie.available_inventory = movie.inventory
      movie.save!
    end
  end
end
