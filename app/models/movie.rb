class Movie < ApplicationRecord
  validates :title, presence: true
  validates :inventory, presence: true
  has_many :rentals

  after_initialize do |movie|
    movie.available_inventory = movie.inventory
    movie.save
  end
end
