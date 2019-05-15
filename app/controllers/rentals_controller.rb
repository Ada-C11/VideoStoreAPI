class RentalsController < ApplicationController
  def check_in
    rental = Rental.find_by(customer_id: params[:customer_id], movie_id: params[:movie_id], check_in_date: nil)

    if rental
      rental.set_check_in

      # include what to do if set_check_in fails?
      render json: rental.as_json(only: [:id, :check_in_date]), status: :ok
    else
      render json: { errors: ["Rental not found"] }, status: :bad_request
    end
  end

  def check_out
    error = "No errors found"

    customer = Customer.find_by(id: params[:customer_id])
    error = "Customer not found" if customer == nil

    movie = Movie.find_by(id: params[:movie_id])
    error = "Movie not found" if movie == nil
    error = "No available copies for checkout" if movie && movie.inventory < 1

    if movie && movie.inventory > 0 && customer
      rental = Rental.new(check_out_date: Date.today,
                          due_date: Date.today + 7.days,
                          movie_id: movie.id,
                          customer_id: customer.id)
      if rental.save
        render json: { id: rental.id, inventory: movie.inventory }, status: :ok
      else
        error = rental.errors.messages
      end
    else
      render json: { errors: error }, status: :bad_request
    end
  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
