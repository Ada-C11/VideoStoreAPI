class RentalsController < ApplicationController
  def checkout
    rental = Rental.new(rental_params)

    rental.checkout = Date.today
    rental.due_date = rental.checkout + 7
    rental.status = "Checked Out"

    if rental.available?(rental_params[:movie_id])
      if rental.save
        render json: rental.as_json(except: [:created_at, :updated_at]), status: :ok
      else
        render json: {errors: rental.errors.messages}, status: :bad_request
      end
    else
      render json: {errors: "Movie unavailable."}, status: :bad_request
    end
  end

  def checkin
    rental = Rental.find_by(movie_id: rental_params[:movie_id], customer_id: rental_params[:customer_id], status: "Checked Out")
    if rental
      rental.status = "Checked In"
      if rental.save
        render json: rental.as_json(except: [:created_at, :updated_at]), status: :ok
      else
        render json: {errors: rental.errors.messages}, status: :bad_request
      end
    else
      render json: {errors: "Rental not located, please check information."}, status: :not_found
    end
  end

  private

  def rental_params
    params.permit(:movie_id, :customer_id)
  end
end
