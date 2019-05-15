class Customer < ApplicationRecord
  has_many :rentals
  has_many :movies, through: :rentals

  validates :name, presence: true

  def movies_checked_out_count
    return 0 # This should be zero until we the optional steps
  end
end
