class Movie < ApplicationRecord
  before_create :set_available_inventory

  validates :title, presence: true
  validates :inventory, presence: true, numericality: true

  has_many :rentals, dependent: :destroy
  has_many :customers, through: :rentals

  def set_available_inventory
    self.available_inventory = self.inventory
  end
end
