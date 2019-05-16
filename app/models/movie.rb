class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true, numericality: { greater_than: -1 }

  def available_inventory
    checked_out_movies = Movies.where(currently_checked_out: true)
    avail_inventory = inventory - checked_out_movies
    return avail_inventory
  end



end
