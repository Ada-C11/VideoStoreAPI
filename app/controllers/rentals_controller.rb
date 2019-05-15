class RentalsController < ApplicationController
  
  def checkout
    rental = Rental.new(rentals_params)
    rental.due_date
     
    if rental.save
      render json: { id: rental.id, movie_id: rental.movie.id, customer_id: rental.customer.id, due_date: rental.due_date }, status: :ok   
    else
      render json: { errors: rental.errors.messages },
        status: :bad_request
    end 
  end

 
  
  private
    def rentals_params
      params.require(:rental).permit(:movie_id, :customer_id, :due_date)
    end
end
