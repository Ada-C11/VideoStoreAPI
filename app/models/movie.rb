class Movie < ApplicationRecord
  has_many :customers, through: :rentals

  validates :title, :inventory, presence: true
end
