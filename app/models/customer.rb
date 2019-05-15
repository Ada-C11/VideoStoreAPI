class Customer < ApplicationRecord
  has_many :rentals
  validates :name, presence: true

  def self.checkout_movies_count(customer)
    customer.movies_checked_out_count += 1
    customer.save
  end

  def self.checkin_movies_count(customer)
    if customer.movies_checked_out_count >= 1
      customer.movies_checked_out_count -= 1
      customer.save
    else
      return false
    end
  end
end
