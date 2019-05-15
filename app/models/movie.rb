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

  def increase_inventory
    self.update(inventory: self.inventory += 1)
  end
end
