class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :customer_id, presence: true
  validates :movie_id, presence: true


  def set_checkout_date
    self.rental.checkout_date = Date.today
    self.rental.due_date = Date.today + 7
    self.rental.currently_checked_out = true
  end
end
