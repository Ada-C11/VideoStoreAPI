class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  validates :checkout_date, presence: true
  validates :due_date, presence: true

  def is_available?
    return self.movie.available_inventory > 0 if self.customer
    return false
  end
end
