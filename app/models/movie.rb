require "pry"

class Movie < ApplicationRecord
  validates :title, presence: true
  validates :inventory, presence: true

  has_many :rentals

  def self.checkout_inventory(movie)
    if movie.available_inventory >= 1
      movie.available_inventory -= 1
      movie.save
    else
      return false
    end
  end

  def self.checkin_inventory(movie, customer)
    if movie.available_inventory < movie.inventory && customer.movies_checked_out_count > 0
      movie.available_inventory += 1
      movie.save

      customer.movies_checked_out_count -= 1
      customer.save
    else
      return false
    end
  end
end
