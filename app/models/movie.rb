class Movie < ApplicationRecord
  has_many :rentals

  validates :title, presence: true
  validates :inventory, presence: true, numericality: true

  def available_inventory
    available = inventory - Rental.where(check_in_date: nil).count
    return available
  end

end
