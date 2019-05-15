class Customer < ApplicationRecord
  has_many :rentals

  def movies_checked_out_count
    self.rentals.where(checkin_date: nil).count
  end
end
