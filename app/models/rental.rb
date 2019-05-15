class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  validates_associated :customer, :movie
  validates :due_date, presence: true
end
