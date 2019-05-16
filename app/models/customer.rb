class Customer < ApplicationRecord
  has_many :rentals
  has_many :movies, through: :rentals

  validates :name, presence: true
  validates :registered_at, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, presence: true
  validates :phone, presence: true

  def movies_checked_out_count
    currently_rented = Rental.where(customer_id: self.id, currently_checked_out: true)
    return currently_rented.length
  end
end
