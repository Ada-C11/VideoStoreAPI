class Movie < ApplicationRecord
  before_create :set_inventory_default
  has_many :rentals

  validates :title, :overview, :release_date, presence: true
  validates :inventory, :available_inventory, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  def available_inventory
    checkedout = 0

    self.rentals.each do |rental|
      if rental.status == "Checked Out"
        checkedout += 1
      end
    end
    return self.inventory - checkedout
  end

  private

  def set_inventory_default
    self.available_inventory = self.inventory
  end
end
