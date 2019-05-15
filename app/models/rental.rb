class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  def set_check_in
    self.update(check_in_date: Date.current)
  end
end
