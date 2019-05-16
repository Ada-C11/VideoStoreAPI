class RemoveMovieIdAndCustomerIdFromRentals < ActiveRecord::Migration[5.2]
  def change
    remove_columns :rentals, :customer_id
    remove_columns :rentals, :movie_id
  end
end
