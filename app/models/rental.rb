class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  def check_in
    if self.checkin_date != nil
      raise RuntimeError("Already checked in!")
    end
    self.checkin_date = Date.today
  end
end
