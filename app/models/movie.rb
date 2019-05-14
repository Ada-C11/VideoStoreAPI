class Movie < ApplicationRecord
  has_many :rentals

  validates :title, presence: true
  validates :inventory, numericality: true
end
