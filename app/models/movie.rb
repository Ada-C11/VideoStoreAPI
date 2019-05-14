class Movie < ApplicationRecord
  has_many :rentals

  validates :title
end
