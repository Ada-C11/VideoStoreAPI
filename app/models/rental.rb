class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :customer_id, presence: true
  validates :movie_id, presence: true

  # def rent_movie(customer, movie)
  #   checked_out = customer.movies_checked_out_count
  #   customer.update(movies_checked_out_count: checked_out +1)

  #   inventory = movie.available_inventory
  #   movie.update(available_inventory: inventory - 1)
  # end
end
