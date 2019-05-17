class Movie < ApplicationRecord
  validates :title, presence: true
  has_many :rentals, dependent: :destroy
end
