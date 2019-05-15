class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  validates_associated :customer, :movie
  validates :due_date, presence: true
  
  def due_date
    DateTime.now + 7.days
  end
end
