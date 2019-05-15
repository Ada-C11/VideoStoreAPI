class Customer < ApplicationRecord
  has_many :rentals
  has_many :movies, through: :rentals

  validates :name, presence: true

  def checked_out_count
    return self.rentals.select { |rental| !rental.returned }.count
  end
end
