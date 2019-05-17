class RentalsController < ApplicationController
  def check_out
    rental = Rental.new(rental_params)

    if rental.movie.available_inventory > 0
      if rental.save
        rental.movie.available_inventory -= 1
        rental.movie.save

        rental.customer.movies_checked_out_count += 1
        rental.customer.save

   
        render json: rental.as_json(only: [:id, :customer_id, :movie_id, :check_out, :due_date]), status: :ok
      else
        render json: {ok: false, errors: rental.errors.messages},
               status: :bad_request
      end
    else
      render json: {ok: false, error_message: "No available inventory"}, status: :bad_request
    end
  end

  def check_in
    rental = Rental.find_by(rental_params)

    if rental
      rental.movie.available_inventory += 1
      rental.movie.save

      rental.customer.movies_checked_out_count -= 1
      rental.customer.save

      render json: rental.as_json(only: [:id, :customer_id, :movie_id]), status: :ok
    else
      render json: {ok: false, error_message: "Could not find rental"}, status: :not_found
    end
  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
