class Movie < ApplicationRecord
  has_many :rentals

  validates :title, :overview, :release_date, :inventory, presence: true
end
