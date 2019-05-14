class Customer < ApplicationRecord
  has_many :rentals

  validates :name
end
