class RentalsController < ApplicationController

  def checkout
    # create a new rental with the movie_id and the customer_id
    rental = Rental.new(rental_params)

    # save rental
    if rental.save
      render json: rental.as_json(only: [rental_params]), status: :ok
    
      # decrease movie inventory
      movie.update(inventory: movie.inventory - 1)
    else
      render json: { 
        ok: false, 
        errors: rental.errors.messages 
      }, 
      status: :bad_request
    end
  end

  def checkin
    movie = Movie.find_by(id: rental_params[:id])
    customer = Customer.find_by(id: rental_params[:id])
    rental = Rental.new(movie_id: movie.id, customer_id: customer.id)

    if rental.save
        movie.update(inventory: movie.inventory + 1) 
        render json: rental.as_json(only:[rental_params]), status: :ok
    else
        render json: {
            ok: false,
            errors: rental.erros.messages
        },
        status: :bad_request
    end
  end

  private

  def rental_params
      params.permit(:movie_id, :customer_id)
  end
end




