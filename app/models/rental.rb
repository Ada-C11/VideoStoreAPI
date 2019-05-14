class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  validates :check_out, presence: true
  validates :check_in, presence: true
end
