class RentalsController < ApplicationController
  def check_in
    rental = Rental.find_by(customer_id: params[:customer_id], movie_id: params[:movie_id], check_in_date: nil)
    movie = Movie.find_by(id: params[:movie_id])

    if rental
      rental.set_check_in
      movie.increase_inventory

      # include what to do if set_check_in, or increase_inventory fail?
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
