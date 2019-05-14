class Movie < ApplicationRecord
  validates :inventory, presence: true
  validates :inventory, numericality: true

  has_many :rentals
end
