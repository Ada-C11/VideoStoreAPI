class RentalsController < ApplicationController

  def checkout
    # find a movie
    movie = Movie.find_by(id: params[:movie_id])

    #find a customer
    customer = Customer.find_by(id: params[:customer_id])

    # create a new rental with the movie_id and the customer_id
    rental = Rental.new(movie.id, customer.id)

    # save rental
    if rental.save
      render json: rental.as_json(only: [:id, :movie_id, :customer_id]), status: :ok
    
      # decrease movie inventory
      movie.update.inventory - 1
    else
      render json: { ok: false, errors: rental.errors.messages }, status: :bad_request
    end
  end
end
