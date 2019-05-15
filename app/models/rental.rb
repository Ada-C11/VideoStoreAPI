class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  def check_in
    if self.checkin_date != nil
      render json: { "errors": ["Already checked in"]}, status: :bad_request
    end
    self.checkin_date = Date.today
  end
end
