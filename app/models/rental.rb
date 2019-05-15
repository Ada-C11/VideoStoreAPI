class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :movie_id, presence: true
  validates :customer_id, presence: true

  def prepare_for_checkout
    self.checkout_date = Date.today
    self.due_date = self.checkout_date + 7.days
    self.currently_checked_out = true

    return self.save
  end
end
