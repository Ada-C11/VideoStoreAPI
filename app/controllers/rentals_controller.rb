class RentalsController < ApplicationController
  def checkout
    rental = Rental.new(customer_id: params[:customer_id], movie_id: params[:movie_id])
    rental.checkout_date = Date.today
    rental.due_date = Date.today + 7
    if rental.save
      render json: rental.as_json(only: [:customer_id, :movie_id, :checkout_date, :due_date, :id]), status: :ok
    else
      render json: {ok: false, errors: rental.errors.messages}, status: :bad_request
    end
  end

  def checkin
    rental = Rental.find_by(customer_id: params[:customer_id], movie_id: params[:movie_id])
    if rental
      rental.destroy
      render json: {ok: true, messages: "Rental checked in successfully"}, status: :success
    else
      render json: {ok: false, errors: "Rental not found"}, status: :bad_request
    end
  end
end
