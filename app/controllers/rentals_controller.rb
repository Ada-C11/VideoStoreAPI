require 'date'

class RentalsController < ApplicationController

  # def checkout
  #   # create a new rental with the movie_id and the customer_id
  #   # rental = Rental.new(movie_id: movie_id, customer_id: customer_id, checkout_date: Date.today, due_date: Date.today + 7, currently_checked_out: true)

  #   rental = Rental.new(rental_params)

  #   puts "VVVVVVVVVVV"
  #   puts "CHECKOUT METHOD"

  #   # decrease movie inventory
  #   movie = Movie.find(movie_id: movie_id)
  #   movie.update(inventory: movie.inventory - 1)
  #   # save rental
  #   if rental.save
  #     render json: rental.as_json(only: [rental_params]), status: :ok
      
  #   else
  #     render json: { 
  #       ok: false, 
  #       errors: rental.errors.messages 
  #     }, 
  #     status: :bad_request
  #   end
  # end

  # def checkin
  #   rental = Rental.find_by(movie_id: rental_params[movie.id], customer_id: rental_params[customer_id])

  #   movie.update(inventory: movie.inventory + 1)
  #   rental.update(checkout_date: nil, due_date: nil, currently_checked_out: false)
    
  #   if rental.save
  #       render json: rental.as_json(only:[:movie_id, :customer_id]), status: :ok
  #   else
  #       render json: {
  #           ok: false,
  #           errors: rental.erros.messages
  #       },
  #       status: :bad_request
  #   end
  # end

  # private

  # def rental_params
  #     params.permit(:movie_id, :customer_id)
  # end
end




