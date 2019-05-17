class Customer < ApplicationRecord
  validates :name, presence: true

  has_many :rentals, dependent: :destroy
  has_many :movies, through: :rentals
end
