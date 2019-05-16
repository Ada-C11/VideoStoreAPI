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

    unless movie.available_inventory > 0
      render status: :precondition_failed, json: { errors: ["This movie is currently unavailable."] }
      return
    end

    rental = Rental.new(check_out: DateTime.now, movie_id: movie.id, customer_id: customer.id, due_date: DateTime.now + 7)

    if rental.save
      movie.decrease_inventory
      customer.increase_checked_out_count
      render status: :ok, json: rental.as_json(only: [:id, :customer_id, :movie_id, :check_out, :due_date])
    else
      render status: :bad_request, json: { errors: rental.errors.messages }
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
