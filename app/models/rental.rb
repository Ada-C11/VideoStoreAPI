class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  validates :movie, :customer, :check_out, :check_in, :status, presence: true

  def movie_avail?(movie_id)
    movie = Movie.find_by(id: movie_id)

    if movie.nil?
      return false
    elsif movie.inventory > 0
      return true
    else
      return false
    end
  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
