class Movie < ApplicationRecord
  has_many :rentals

  validates :title, presence: true
  validates :inventory, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def available_inventory
    inventory = self.inventory 
    rentals = self.rentals.count{ |rental| rental.return_date.nil? }
    avail_inventory = inventory - rentals
    return avail_inventory
  end
end
