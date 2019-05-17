class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :customer_id, presence: true
  validates :movie_id, presence: true


  def set_checkout_date
    if self.currently_checked_out == true
      return false
    else
      self.checkout_date = Date.today
      self.due_date = self.checkout_date + 7
      self.currently_checked_out = true
      return self.save
    end
  end

  def set_checkin_date
    if self.currently_checked_out == false
      return false
    else
      self.checkin_date = Date.today
      self.currently_checked_out = false
      return self.save
    end
  end
  
end
