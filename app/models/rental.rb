class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  def available?(movie_id)
    movie = Movie.find_by(id: movie_id)

    if !movie
      return false
    elsif movie.available_inventory > 0
      return true
    else
      return false
    end
  end
end
