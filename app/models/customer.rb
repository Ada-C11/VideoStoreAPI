class Customer < ApplicationRecord
  validates :name, :phone, :address, :city, :state, :postal_code, :registered_at, presence: true

  has_many :rentals

  def movies_checked_out_count
    total = 0
    num_unavailable = 0
    num_unavailable = 0
    self.rentals.each do |rental|
      if rental.status == "unavailable"
        num_unavailable += 1
      end
    end
    return (movies_count = num_unavailable)
  end
end
