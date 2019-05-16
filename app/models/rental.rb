class Rental < ApplicationRecord
  belongs_to :movie, dependent: :delete
  belongs_to :customer, dependent: :delete
end
