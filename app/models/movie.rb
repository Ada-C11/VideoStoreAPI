class Movie < ApplicationRecord
  has_many :rentals

  def available_inventory
    available = inventory - rentals.count
    return available
  end

end
