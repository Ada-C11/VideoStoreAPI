class RentalsController < ApplicationController
  def check_out
    movie = Movie.find_by(id: params[:movie_id])
    customer = Customer.find_by(id: params[:customer_id])

    if movie.nil? && customer.nil?
      render status: :not_found, json: { errors: ["Customer with id #{params[:customer_id]} was not found.", "Movie with id #{params[:movie_id]} was not found"] }
      return
    elsif movie.nil?
      render status: :not_found, json: { errors: ["Movie with id #{params[:movie_id]} was not found."] }
      return
    elsif customer.nil?
      render status: :not_found, json: { errors: ["Customer with id #{params[:customer_id]} was not found."] }
      return
    end

    # make sure it can find movie, movie as avail inventory, can find customer

    rental = Rental.new(check_out: DateTime.now, movie_id: movie.id, customer_id: customer.id, due_date: DateTime.now + 7)

    if rental.save
      movie.decrease_inventory
      render status: :ok, json: rental.as_json(only: [:id, :customer_id, :movie_id, :check_out, :due_date])
    else
      render json: { message: "No rental created" }
    end
  end

  def check_in
    movie = Movie.find_by(id: params[:movie][:id])
    customer = Customer.find_by(id: params[:customer][:id])
    rental = Rental.where(customer_id: customer.id, movie_id: movie.id)

    # rental.update(check_in: DateTime.now )

    #if successful
    # Increase Inventory by 1 (via helper method)
    #else
    # Error message
    #end

  end
end
