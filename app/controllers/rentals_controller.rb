class RentalsController < ApplicationController
  def check_out
    rental = Rental.new(rental_params)
    rental.check_out = Date.today
    rental.due_date = Date.today + 7.days

    if rental.save
      customer = Customer.find_by(id: rental.customer_id)
      customer.rental_ids << rental.id
      checkouts = customer.movies_checked_out_count
      checkouts += 1
      customer.update_attributes(movies_checked_out_count: checkouts)

      movie = Movie.find_by(id: rental.movie_id)
      movie.rental_ids << rental.id
      inventory = movie.available_inventory
      inventory -= 1
      movie.update_attributes(available_inventory: inventory)

      render status: :ok, json: rental.as_json(only: [:id, :check_out, :due_date])
    else
      render status: :bad_request, json: { "errors": rental.errors.messages }
    end
  end

  def check_in
  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
