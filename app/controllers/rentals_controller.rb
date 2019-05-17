class RentalsController < ApplicationController
  def checkout
    rental = Rental.new(movie_id: params[:movie_id],
                        customer_id: params[:customer_id],
                        checkout: DateTime.now,
                        due: DateTime.now + 7.days)

    if rental.save
      render status: :ok, json: rental.as_json(only: [:movie_id, :customer_id, :checkout, :due, :returned])
    else
      render status: :bad_request, json: {errors: rental.errors.messages}
    end
  end

  def checkin
    rental = Rental.find_by(movie_id: params[:movie_id],
                            customer_id: params[:customer_id],
                            returned: false)
    unless rental
      render status: :not_found, json: {errors: ["The rental you requested was not found"]}
      return
    end
    rental.returned = true
    if rental.save
      render status: :ok, json: rental.as_json(only: [:movie_id, :customer_id, :checkout, :due, :returned])
    else
      render status: :bad_request, json: {errors: [rental.errors.messages]}
    end
  end
end
