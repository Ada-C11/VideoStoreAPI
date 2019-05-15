class Customer < ApplicationRecord
  validates :name, presence: true
  validates :phone, presence: true

  def movies_checked_out_count
    return 0 
  end 

end
