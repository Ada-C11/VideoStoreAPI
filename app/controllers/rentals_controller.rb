require "pry"

class RentalsController < ApplicationController
  def checkout
    rental = Rental.new(rental_params)
    customer = find_customer
    movie = find_movie

    if movie.available_inventory > 0
      rental.due_date = Date.today + 7
      if rental.save
        render json: {rental_id: rental.id}, status: :ok
        customer.movies_checked_out_count += 1
        movie.available_inventory -= 1
      else
        render_error(:bad_request, rental.errors.messages)
      end
    else
      render_error(:forbidden, "Not in stock.")
    end
  end

  def checkin
    customer = Customer.find_by(id: rental_params[:customer_id])
    movie = Movie.find_by(id: rental_params[:movie_id])
    rental = Rental.find_by(customer_id: rental_params[:customer_id], movie_id: rental_params[:movie_id])

    if rental
      rental.movie.available_inventory += 1
      rental.movie.save
      rental.customer.movies_checked_out_count -= 1
      rental.customer.save
      render json: {id: rental.id}, status: :ok
    else
      render json: {errors: ["Rental could not be located"]}, status: :not_found
    end
  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
