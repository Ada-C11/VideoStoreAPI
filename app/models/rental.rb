class Rental < ApplicationRecord
  validates :customer_id, presence: true
  validates :movie_id, presence: true
  validates :checkout_date, presence: true
  validates :due_date, presence: true

  belongs_to :customers
  belongs_to :movies
end
