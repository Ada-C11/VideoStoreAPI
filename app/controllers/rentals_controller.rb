class RentalsController < ApplicationController

  def check_out
    error = "No errors found"

    customer  = Customer.find_by(id: params[:customer_id])
    error = "Customer not found" if customer == nil

    movie  = Movie.find_by(id: params[:movie_id])
    error = "Movie not found" if movie == nil
    error = "No available copies for checkout" if movie && movie.inventory < 1

    if movie && movie.inventory > 0 && customer
      rental = Rental.new(check_out_date: Date.today, 
                          due_date: Date.today + 7.days, 
                          movie_id: movie.id, 
                          customer_id: customer.id )
      if rental.save
        render json: { id: rental.id, inventory: movie.inventory }, status: :ok
        movie.update(inventory: movie.inventory - 1)
      else
        error = rental.errors.messages
      end
    else
      render json: { errors: error }, status: :bad_request 
    end
  end

  private

  def rental_params
    params.permit(:movie_id, :customer_id)
  end
end
