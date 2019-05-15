class RentalsController < ApplicationController
  def check_in
    rental = Rental.find_by(customer_id: params[:customer_id], movie_id: params[:movie_id], check_in_date: nil)
    customer = Customer.find_by(id: params[:customer_id])
    movie = Movie.find_by(id: params[:movie_id])

    if rental
      rental.check_in_date = Date.current
      movie.inventory += 1
      movie.save
      # adjust customer check out count?
      render json: rental.as_json(only: [:id, :check_in_date]), status: :ok
    else
      render json: { errors: ["Rental not found"] }, status: :bad_request
    end
  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
