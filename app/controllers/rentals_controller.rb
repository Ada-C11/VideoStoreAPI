require "date"

class RentalsController < ApplicationController
  def check_out
    rental = Rental.new(rental_params)
    customer = Customer.find_by(id: rental.customer_id)
    movie = Movie.find_by(id: rental.movie_id)

    if movie.available_inventory == 0
      render status: :not_found, json: { ok: false, mesages: "Movie not found" }
    end

    rental.check_out = Date.today
    rental.due_date = rental.check_out + 7

    if rental.save
      render status: :ok, json: { id: rental.id }
      customer_movie_count = customer.movies_checked_out_count
      customer.update(movies_checked_out_count: customer_movie_count + 1)

      movie_inventory = movie.available_inventory
      movie.update(available_inventory: movie_inventory - 1)
    else
      render status: :bad_request, json: { ok: false, errors: rental.errors }
    end
  end

  def check_in
    rental = Rental.where(["movie_id = ? and customer_id = ?", params[:rental][:movie_id], params[:rental][:customer_id]]).first
    rental.check_in = Date.today
    customer = Customer.find_by(id: rental.customer_id)
    movie = Movie.find_by(id: rental.movie_id)

    if rental.save
      render json: { id: rental.id }, status: :ok
      customer_movie_count = customer.movies_checked_out_count
      customer.update(movies_checked_out_count: customer_movie_count - 1)

      movie_inventory = movie.available_inventory
      movie.update(available_inventory: movie_inventory + 1)
    else
      render status: :not_found, json: { ok: false, mesages: "Movie not found" }
    end
  end

  private

  def rental_params
    params.permit(:movie_id, :customer_id)
  end
end
