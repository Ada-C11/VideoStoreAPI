class RentalsController < ApplicationController

  def check_out
    customer  = Customer.find_by(id: params[:customer_id])
    movie  = Movie.find_by(id: params[:movie_id])
    if movie.inventory > 0
      rental = Rental.new(check_out_date: Date.today, due_date: Date.today + 7.days, movie_id: movie.id, customer_id: customer.id )
      if rental.save
        render json: { id: rental.id, inventory: movie.inventory }, status: :ok
        movie.update(inventory: movie.inventory - 1)
      else
        render json: { errors: rental.errors.messages }, status: :bad_request
      end
    else
      render json: { errors: "No available copies for checkout" }, status: :bad_request 
    end
  end

  private

  def rental_params
    params.permit(:movie_id, :customer_id)
  end
end
