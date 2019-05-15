class RentalsController < ApplicationController
  def check_in
    rental = Rental.find_by(customer_id: params[:customer_id], movie_id: params[:movie_id])
    # check_in: nil

    if rental
    else
      render json: { errors: ["Rental not found"] }
    end
  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
