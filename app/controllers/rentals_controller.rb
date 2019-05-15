class RentalsController < ApplicationController
  def check_out
    rental = Rental.new(rental_params)

    rental.checkout_date = Date.current
    rental.due_date = rental.checkout_date + 7

    if rental.save
      render status: :ok, json: {id: rental.id}
    else
      render status: :bad_request, json: {errors: rental.errors.messages}
    end
  end

  def check_in
    rental = Rental.find_by(id: params[:id])
    unless rental 
      head :not_found
      return 
    end
    
    rental.checkin_date = Date.current

    if rental.save
      render status: :ok, json: {id: rental.id}
    else 
      render status: :bad_request, json: {errors: rental.errors.messages}
    end
  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
