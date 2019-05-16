class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  validates :checkout_date, presence: true
  validates :due_date, presence: true
  validate :is_available?

  def is_available?
    errors.add(:movie, "availiable quantity must be more than 0") unless movie.available_inventory > 0 
  end

end

