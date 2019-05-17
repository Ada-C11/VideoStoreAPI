class RentalsController < ApplicationController
  
  def index
    rentals = Rental.all
    render json:  rentals.as_json(only: [:movie_id, :customer_id]), status: :ok
  end

end


  def rental_params
      params.permit(:movie_id, :customer_id)
  end




