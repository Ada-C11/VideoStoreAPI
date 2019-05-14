class RentalsController < ApplicationController
  def checkout
    rental = Rental.new(movie_id: params[:movie_id],
                        customer_id: params[:customer_id],
                        checkout: DateTime.now,
                        due: DateTime.now + 7.days)

    if rental.save
      render status: :ok, json: rental.as_json(only: [:movie_id, :customer_id, :checkout, :due])
    else
      render status: :bad_request, json: { errors: rental.errors.messages }
    end
  end

  def checkin
  end
end
