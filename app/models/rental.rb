class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  # don't think we need to, but validate for movie_id and customer_id if needed later
  validates :checkout_date, presence: true
end
