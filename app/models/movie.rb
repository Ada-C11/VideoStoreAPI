class Movie < ApplicationRecord
  validates :inventory, presence: true
  validates :inventory, numericality: true
  validates :title, presence: true

  has_many :rentals
end
