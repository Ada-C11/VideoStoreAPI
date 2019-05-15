class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence: :true

  def available_inventory
    current_rentals = Rental.where(movie_id: self.id, currently_checked_out: true)
    avail_inventory = inventory - current_rentals.length
    return avail_inventory
  end
end
