class RentalsController < ApplicationController
  def check_out
    rental = Rental.new(rental_params)
    rental.check_out = Date.today
    rental.check_in = rental.check_out + 7
    rental.status = "unavailable"

    if rental.movie_avail?(rental_params[:movie_id])
      if rental.save
        customer = Customer.find_by(id: rental.customer_id)
        customer.movies_checked_out_count += 1
        customer.save

        movie = Movie.find_by(id: rental.movie_id)
        movie.available_inventory -= 1
        movie.save
        render json: rental.as_json(except: [:created_at, :updated_at]), status: :ok
      else
        render json: {
                 errors: rental.errors.messages,
               }, status: :bad_request
      end
    else
      render json: {
               errors: "Movie not available",
             }, status: :bad_request
    end
  end

  def check_in
    rental = Rental.find_by(movie_id: rental_params[:movie_id], customer_id: rental_params[:customer_id], status: "unavailable")
    if rental
      rental.status = "available"
      if rental.save
        customer = Customer.find_by(id: rental.customer_id)
        customer.movies_checked_out_count -= 1
        customer.save

        movie = Movie.find_by(id: rental.movie_id)
        movie.available_inventory += 1
        movie.save
        render json: rental.as_json(except: [:created_at, :updated_at]), status: :ok
      else
        render json: {
          errors: rental.errors.messages,
        }, status: :bad_request
      end
    else
      render json: {
        errors: "Not able to find rental",
      }, status: :not_found
    end
  end

  private

  def rental_params
    params.permit(:movie_id, :customer_id, :check_in, :check_out, :status)
  end
end
