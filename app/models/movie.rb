class Movie < ApplicationRecord
  has_many :customers, through: :rentals

  validates :name, presence: true
end
