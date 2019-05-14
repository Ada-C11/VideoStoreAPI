class RentalsController < ApplicationController
  def checkout
    rental = Rental.new(movie_id: params[:movie_id], customer_id: params[:customer_id], checkout_date: Date.today, due_date: (Date.today + 7))
    movie = Movie.find_by(id: rental.movie_id)
    if movie.available_inventory <= 0
      render json: { ok: false, message: "Not enough copies in inventory" }, status: :bad_request
    else
      movie.available_inventory -= 1
    end

    if rental.save
      movie.save
      customer = Customer.find_by(id: rental.customer_id)
      customer.movies_checked_out_count += 1
      customer.save
    else
      render json: { ok: false, message: rental.errors.messages }, status: :bad_request
    end
  end

  def checkin
  end

  private

  def rental_params
    params.require(:rental).permit(:movie_id, :customer_id)
  end
end
