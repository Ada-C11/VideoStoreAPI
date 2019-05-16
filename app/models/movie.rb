class Movie < ApplicationRecord
  has_many :rentals

  validates :title, presence: true
  validates :inventory, numericality: true
  validates :overview, presence: true
  validates :release_date, presence: true

  def set_available_inventory
    self.available_inventory = self.inventory
  end
end
