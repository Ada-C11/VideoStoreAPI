class RentalsController < ApplicationController
  def check_out
    movie = Movie.find_by(id: rental_params[:movie_id])
    if movie.available_inventory > 0
      rental = Rental.new(rental_params.merge(checkout_date: Date.today, due_date: Date.today + 7))
    else 
      render json: { "errors": {"title": ["Movie '#{movie.title}' is not available"]}}, status: :bad_request
      return
    end

    if rental.save
      render json: {id: rental.id}, status: :ok
    else
      render json: { errors: rental.errors.messages}, status: :bad_request
    end  
  end

  def check_in
    rental = Rental.where(customer_id: rental_params[:customer_id], movie_id: rental_params[:movie_id], checkin_date: nil).first 
    if rental 
      rental.check_in
      render json: {id: rental.id}, status: :ok  if rental.save
    else
      render json: { "errors": ["Rental with movie'#{rental_params[:movie_id]}' is not found"]}, status: :bad_request
    end
  end

  private 
    def rental_params
      params.permit(:customer_id, :movie_id)
    end
end
