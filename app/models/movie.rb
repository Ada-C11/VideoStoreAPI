class Movie < ApplicationRecord
  has_many :rentals
  validates :title, :overview, :inventory, :release_date, presence: true
  
  def available_inventory
    if self.inventory > 0
      available_inventory = self.inventory - self.rentals.where(checkin_date: nil).count
    else
      available_inventory = 0
    end
  end
end