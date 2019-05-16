class RentalsController < ApplicationController
  def check_out
    movie = Movie.find_by(id: params[:movie][:id])
    customer = Customer.find_by(id: params[:customer][:id])
    rental = Rental.new(check_out: DateTime.now, movie_id: movie.id, customer_id: customer.id, due_date: DateTime.now + 7)

    if rental.save
      movie.decrease_inventory
      render status: :ok, json: rental.as_json(only: [:id, :customer_id, :movie_id, :check_out, :due_date])
    else
      # Error message
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
