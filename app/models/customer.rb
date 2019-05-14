class Customer < ApplicationRecord
  validates :name, presence: true

  def self.checkout_inventory(movie)
    if movie.available_inventory > 1
      movie.available_inventory -= 1
    else
      return false
    end
  end
end
