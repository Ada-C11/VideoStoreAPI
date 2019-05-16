class Customer < ApplicationRecord
  has_many :rentals, dependent: :nullify
end
