class RentalsController < ApplicationController

  def checkin
    rental = Rental.find_by(customer_id: rental_params[:customer_id], movie_id: rental_params[:movie_id])
    if rental
      render json: {id: rental.id, movie_id: rental.movie.id, customer_id: rental.customer.id}, status: :ok
    else
      render json: [{errors: {rental: ["Rental not found for customer #{rental_params[:customer_id]}, and movie #{rental_params[:movie_id]}"]}}],
             status: :not_found
    end
  end
  
  def checkout
    rental = Rental.new(rental_params)
    rental.set_due_date
     
    if rental.save
      render json: [{ id: rental.id, movie_id: rental.movie.id, customer_id: rental.customer.id, due_date: rental.due_date }], status: :ok   
    else
      render json: [{ errors: rental.errors.messages }],
        status: :bad_request
    end 
  end
 
  
  private
    def rental_params
      params.require(:rental).permit(:movie_id, :customer_id, :due_date)
    end
end
