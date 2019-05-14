class Customer < ApplicationRecord
  has_many :rentals

  def movies_checked_out
    return rentals.count
  end
end
