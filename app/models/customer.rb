class Customer < ApplicationRecord
  validates :name, presence: true
  has_many :rentals

  after_initialize do |customer|
    customer.movies_checked_out_count = 0
    customer.save
  end
end
