class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  validates :checkout, :due, presence: true

  validate :availability

  def availability
    if self.movie.number_available < 1
      errors.add(:inventory, "All copies of that movie are currently checked out")
    end
  end
end
