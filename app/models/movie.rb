class Movie < ApplicationRecord
  has_many :rentals

  validates :title, presence: true
  # validates :overview, presence: true
  # validates :release_date, presence: true
  validates :inventory, presence: true, numericality: true

  def available_inventory
    available = inventory - rentals.count
    return available
  end

  def decrease_inventory
    if inventory > 0 
      self.update(inventory: inventory - 1)
    end
    return inventory
  end
end
