class Movie < ApplicationRecord
  validates :title, :inventory, presence: true
  validates :available_inventory, numericality: { greater_than: -1 }
  
  def reduce_avail_inventory
    amount = self.available_inventory
    
    if amount != 0
     self.available_inventory = amount - 1
     return self.save!
    else
      return false
    end
  end
end
