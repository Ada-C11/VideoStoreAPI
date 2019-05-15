class RentalsController < ApplicationController
  def check_out
    rental = Rental.new(rental_params)

    if rental.save
      render status: :ok, json: {id: rental.id}
    else
      render status: :bad_request, json: {errors: rental.errors.messages}
    end
    # rental = Rental.new

    # rental.checkout_date = Date.current
    # rental.due_date = rental.checkout_date + 7

    # rental.save
  end

  def check_in
  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
