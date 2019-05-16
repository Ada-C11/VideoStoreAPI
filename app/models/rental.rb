class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  validates_associated :customer, :movie
  
  def set_due_date
    self.created_at + 7.days  
  end
end
