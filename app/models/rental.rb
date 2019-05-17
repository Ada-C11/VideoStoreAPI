class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie
before_create :set_rental_dates

def set_rental_dates
  self.check_out = Date.today
  self.due_date = Date.today + 7.days
end


end
