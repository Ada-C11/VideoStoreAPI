class Customer < ApplicationRecord
  has_many :rentals
  validates :name, presence: true

  def increase_checked_out_count
    self.movies_checked_out_count += 1
    self.save
  end

  def decrease_checked_out_count
    self.movies_checked_out_count -= 1
    self.save
  end
end
