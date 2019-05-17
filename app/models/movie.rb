class Movie < ApplicationRecord
  validates :title, :inventory, presence: true
  validates :available_inventory, numericality: { greater_than: -1 }
  
  def reduce_avail_inventory
    amount = self.available_inventory
    
    if amount != 0
     self.available_inventory -= 1
     return self.save!
    else
      return false
    end
  end
  
  def increase_available_inventory
    original_amount = self.available_inventory

    if self.inventory > original_amount
      self.available_inventory += 1
      return self.save!
    end
  end
end
