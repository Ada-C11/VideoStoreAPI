class Movie < ApplicationRecord
  has_many :rentals
  validates :title, :overview, :inventory, :release_date, presence: true
  
  def available_inventory
    if self.inventory
      available_inventory = self.inventory - self.rentals.count
    else
      available_inventory = nil
    end
  end
end