class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  def prepare_for_checkout
    self.checkout_date = Date.today
    self.due_date = self.checkout_date + 7.days
    self.currently_checked_out = true

    self.save
  end
end
