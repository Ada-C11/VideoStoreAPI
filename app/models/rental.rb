class Rental < ApplicationRecord
  belongs_to :movie, dependent: :delete
  belongs_to :customer, dependent: :delete

  def checkout_update_customer_movie(customer, movie)
    existing_movie_count = customer.movies_checked_out_count
    customer.update(movies_checked_out_count: existing_movie_count + 1)

    current_movie_inventory = movie.available_inventory
    movie.update(available_inventory: current_movie_inventory - 1)
  end

  def checkin_update_customer_movie(customer, movie)
    existing_movie_count = customer.movies_checked_out_count
    customer.update(movies_checked_out_count: existing_movie_count - 1)

    current_movie_inventory = movie.available_inventory
    movie.update(available_inventory: current_movie_inventory + 1)
  end

  def self.return(customer_id, movie_id)
    rental = Rental.find_by(customer_id: customer_id, movie_id: movie_id)
    return rental
  end
end
