class Movie < ApplicationRecord
  validates :title, presence: true
  validates :inventory, presence: true

  has_many :rentals

  def self.checkout_inventory(movie)
    if movie.available_inventory >= 1
      movie.available_inventory -= 1
    else
      return false
    end
  end

  def self.checkin_inventory(movie)
    if movie.available_inventory < movie.inventory
      movie.available_inventory += 1
      movie.save
    else
      return false
    end
  end
end
