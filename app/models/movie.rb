class Movie < ApplicationRecord
  has_many :rentals

  validates :title, presence: true

  def available_inventory
    checkedout = 0

    self.rentals.each do |rental|
      if rental.status == "Checked Out"
        checkedout += 1
      end
    end
    return self.inventory - checkedout
  end
end
