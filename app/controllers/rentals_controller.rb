# frozen_string_literal: true

class RentalsController < ApplicationController
  def checkout
    rental = Rental.new(rental_params)
    rental.save

    rental.movie.available_inventory -= 1
    rental.movie.save
    rental.customer.movies_checked_out_count += 1
    rental.customer.save
    rental.due_date = rental.created_at + 7

    if rental.save
      render json: rental.as_json(only: %i[customer_id movie_id]), status: :ok
    else
      render json: { errors: rental.errors.messages },
             status: :bad_request
    end
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
