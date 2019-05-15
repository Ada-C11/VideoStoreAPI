class RentalsController < ApplicationController
  def check_out
    rental = Rental.new(rental_params)
    rental.return_date = Time.now + (60 * 60 * 24 * 7)
    if rental.save
      render status: :ok, json: { id: rental.id }
    else
      render json: { ok: false, errors: rental.errors.messages },
        status: :bad_request
    end
  end

  def check_in
  end

  private

  def rental_params
    params.permit(:movie_id, :customer_id)
  end
end
