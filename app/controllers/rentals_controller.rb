class RentalsController < ApplicationController
  def checkout
    rental = Rental.new(rental_params)
    customer = find_customer
    movie = find_movie

    if movie.available_inventory > 0
      rental.due_date = Date.today + 7
      if rental.save
        render json: { rental_id: rental.id }, status: :ok
      else
        render_error(:bad_request, rental.errors.messages)
      end
    else
      render_error(:forbidden, "No movie in available inventory.")
    end
  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end

  def find_customer
    return Customer.find_by(id: rental_params[:customer_id])
  end

  def find_movie
    return Movie.find_by(id: rental_params[:movie_id])
  end
end
