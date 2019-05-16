class RentalsController < ApplicationController
  def checkin
    rental = Rental.find_by(customer_id: rentals_params[:customer_id], movie_id: rentals_params[:movie_id])
    if rental
      render json: {id: rental.id, movie_id: rental.movie.id, customer_id: rental.customer.id}, status: :ok
    else
      render json: {errors: {rental: ["Rental not found for customer #{rental_params[:customer_id]}, and movie #{rental_params[:movie_id]}"]}},
             status: :not_found
    end
  end
end
