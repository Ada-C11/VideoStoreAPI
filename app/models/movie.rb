class Movie < ApplicationRecord
  before_create :set_available_inventory_default

  validates :title, presence: true

  private

  def set_available_inventory_default
    self.available_inventory = self.inventory
  end
end
