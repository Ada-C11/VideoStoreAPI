require "pry"

class RentalsController < ApplicationController
  def checkout
    movie = Movie.find_by(id: rental_params[:movie_id])
    if !movie
      render json: { "errors": { "movie": ["Movie not found."] } }, status: :bad_request
    else
      customer = Customer.find_by(id: rental_params[:customer_id])
      if !customer
        render json: { "errors": { "customer": ["Customer not found."] } }, status: :bad_request
      else
        checkout_date = Date.today
        due_date = checkout_date + 7
        rental = Rental.new(customer_id: customer.id, checkout_date: checkout_date, due_date: due_date, movie_id: movie.id)

        if rental.movie.available_inventory > 0
          if rental.save
            customer.movies_checked_out_count += 1
            movie.available_inventory -= 1
            if !rental.save
              render json: { "errors": { "movie": rental.movie.errors.messages } }, status: :bad_request
            else
              render json: rental.as_json(only: [:id]), status: :ok
            end
          else
            render json: { "errors": { "movie": rental.errors.messages } }, status: :bad_request
          end
        else
          render json: { "errors": { "movie": ["#{movie.title} is out of stock"] } }, status: :bad_request
        end
      end
    end
  end

  def checkin
    customer = Customer.find_by(id: rental_params[:customer_id])
    movie = Movie.find_by(id: rental_params[:movie_id])
    rental = Rental.find_by(customer_id: rental_params[:customer_id], movie_id: rental_params[:movie_id])

<<<<<<< HEAD
    customer.movies_checked_out_count -= 1
    movie.available_inventory += 1
    binding.pry
    if rental.save
      render json: { id: rental.id }, status: :ok
=======
    if rental
      rental.movie.available_inventory += 1
      rental.movie.save
      rental.customer.movies_checked_out_count -= 1
      rental.customer.save
      render json: {id: rental.id}, status: :ok
    else
      render json: {errors: ["Rental could not be located"]}, status: :not_found
>>>>>>> 058d121aac852cb889b78f2c99af0bcf21344e4c
    end
  end
  
  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
