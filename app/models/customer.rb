class Customer < ApplicationRecord
  has_many :rentals

  def movies_checked_out_count
    return Rental.where(check_in_date: nil).count
  end
end
