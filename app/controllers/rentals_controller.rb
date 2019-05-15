# frozen_string_literal: true

class RentalsController < ApplicationController
  def checkout
    rental = Rental.new(rental_params)
    rental.save

    if rental.movie && rental.customer
      rental.movie.available_inventory -= 1
      rental.movie.save
      rental.customer.movies_checked_out_count += 1
      rental.customer.save
      rental.due_date = rental.created_at + 7
    end

    if rental.save
      render json: rental.as_json(only: %i[customer_id movie_id]), status: :ok
    else
      render json: { errors: rental.errors.messages },
             status: :bad_request
    end
  end

  def checkin; end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
