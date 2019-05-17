class RentalsController < ApplicationController
  def checkout
    # change the inventory by -1, add update action to movie
    # create an instance of Rental, with today's date in checkout column and due date defined as today + 7 days
    movie = Movie.find_by(id: params[:movie_id])
    if movie == nil
      render json: { error: "Movie was not found in database or no movie id was provided." }, status: :no_content
      return
    end

    if movie.available_inventory > 0
      rental = Rental.new(rental_params)
      rental.checkout_date = Date.today
      rental.due_date = Date.today + 7
      if rental.save
        customer = Customer.find_by(id: params[:customer_id])
        render json: { id: rental.id }, status: :ok

        rental.checkout_update_customer_movie(customer, movie)
        # find customer; update movies_checked_out_count column
        # find movie; update available_inventory
      else
        render json: { error: rental.errors.messages }, status: :bad_request
      end
    else
      render json: { message: "This movie is not available for checkout." }, status: :forbidden
    end
  end

  def checkin
    customer_id = params[:customer_id]
    movie_id = params[:movie_id]
    customer = Customer.find_by(id: customer_id)
    movie = Movie.find_by(id: movie_id)
    if !customer
      render json: { error: "Customer id #{params[:customer_id]}not found" }, status: :no_content
      return
    end
    if !movie
      render json: { error: "Movie id #{params[:movie_id]} not found" }, status: :no_content
      return
    end
    rental = Rental.return(customer_id, movie_id)
    if !rental
      render json: { error: "rental not found" }, status: :no_content
      return
    end
    rental.checked_in_date = Date.today
    rental.save
    rental.checkin_update_customer_movie(customer, movie)
    render json: { id: rental.id, message: "checked-in successful" }, status: :ok
  end

  private

  def rental_params
    params.permit(:movie_id, :customer_id)
  end
end
