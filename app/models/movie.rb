class Movie < ApplicationRecord
  validates :title, presence: true
  validates :inventory, presence: true
  validates :inventory, numericality: true
  # validates :overview, presence: true
  # validates :release_date, presence: true

  def available_inventory
    return self.inventory
  end
end
