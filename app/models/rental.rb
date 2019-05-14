class Rental < ApplicationRecord
  validates :movie_id, presence: true
  validates :customer_id, presence: true
end
