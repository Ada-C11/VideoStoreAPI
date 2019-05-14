class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  validates :checkout, :due, presence: true
end
