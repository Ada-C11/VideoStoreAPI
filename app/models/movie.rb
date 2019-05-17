class Movie < ApplicationRecord
  has_many :rentals
  before_create :set_available_inventory_default

  validates :title, presence: true

  def decrease_inventory
    if self.available_inventory > 0
      self.available_inventory -= 1
      self.save
    end
  end

  def increase_inventory
    self.available_inventory += 1
    self.save
  end

  private

  def set_available_inventory_default
    self.available_inventory = self.inventory
  end
end
