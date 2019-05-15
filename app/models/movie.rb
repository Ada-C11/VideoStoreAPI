class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence: true
  validates :inventory, presence: true
  validates :inventory, numericality: true
  # validates :overview, presence: true
  # validates :release_date, presence: true

  def available_inventory
    return self.inventory
  end

  def reduce_inventory
    return self.update(inventory: self.inventory - 1)
  end

  def increase_inventory
    return self.update(inventory: self.inventory + 1)
  end
end
