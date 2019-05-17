class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, :inventory, presence: true

  def number_available
    checked_out = self.rentals.select { |rental| !rental.returned }.count

    return inventory - checked_out
  end
end
