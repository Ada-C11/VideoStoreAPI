class Customer < ApplicationRecord
  has_many :rentals
  has_many :movies, through: :rentals

  validates :name, presence: true
  validates :phone, presence: true

  def movies_checked_out_count
    checkouts = []
    Rental.all.each do |rental|
      if rental.customer_id == self.id && rental.checkin_date.nil?
      checkouts << rental
      end
    end

    return checkouts.count
  end 
end