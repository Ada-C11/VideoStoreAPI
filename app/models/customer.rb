class Customer < ApplicationRecord
  has_many :movies, through: :rentals

  validates :name, :inventory, presence: true
end
