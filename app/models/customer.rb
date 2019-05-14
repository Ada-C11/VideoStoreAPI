class Customer < ApplicationRecord
  has_many :rentals

  validates :name, prescence: true
end
