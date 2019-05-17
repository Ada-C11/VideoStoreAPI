require 'pry'
class RentalsController < ApplicationController
  
  def checkout
    rental = Rental.new(rental_params)
    movie = Movie.find_by(id: params[:movie_id])

    rental.checkout_date = Date.today
    rental.due_date = rental.checkout_date + 7
    
    if movie && movie.reduce_avail_inventory
      if rental.save
        render json: rental.as_json(only: [:id, :movie_id, :customer_id, :due_date]),
        status: :ok
      else 
        render json: { errors: [rental.errors.messages] },
        status: :bad_request
      end
    else
      render json: { errors: ["Could not create rental request"] },
      status: :bad_request
    end
  end
  
  def checkin
    movie = Movie.find_by(id: params[:movie_id])

    if movie.nil?
      render json: { errors: ["The movie with id #{params[:id]} could not be found"] }, status: :not_found
    elsif movie.increase_available_inventory
      render json: movie.as_json(only: [:available_inventory]), status: :ok
    else
      render json: { errors: ["The movie with id #{params[:id]} already have full inventory"] }, status: :bad_request
    end
  end

  private

  def rental_params
    params.permit(:movie_id, :customer_id)
  end
end
