class RentalsController < ApplicationController

  def check_out
    customer  = Customer.find_by(id: rental_params[:customer_id])
    movie  = Movie.find_by(id: rental_params[:movie_id])
    rental = Rental.new(check_out_date: Date.today, due_date: Date.today + 7.days, movie_id: movie.id, customer_id: customer.id )
    if rental.save
      render json: { id: rental.id }, status: :ok
    else
      render json: { errors: rental.errors.messages }, status: :bad_request
    end
  end

  private

  def rental_params
    params.permit(:movie_id, :customer_id)
  end
end
