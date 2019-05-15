class RentalsController < ApplicationController
  def checkout
  end

  def checkin
    customer = Customer.find_by(id: rental_params[:customer_id])
    movie = Movie.find_by(id: rental_params[:movie_id])
    if customer && movie
      rental = Rental.find_by(customer_id: customer.id, movie_id: movie.id)
      rental.destroy
      movie.update(available_inventory: movie.available_inventory + 1)
      customer.update(movies_checked_out_count: customer.movies_checked_out_count + 1)
      render json: { status: :ok }
    else
      render json: { errors: { movie: ["No movie by this id found"] } }, status: :not_found
    end
  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
