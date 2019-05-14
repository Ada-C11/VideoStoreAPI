class Movie < ApplicationRecord
  has_many :rentals

  validates :title, prescence: true
  validates :inventory, prescence: true, numericality: { greater_than_or_equal_to: 0 }
end
