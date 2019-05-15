

class RentalsController < ApplicationController
  before_action :find_customer, only: [:checkout, :checkin]
  before_action :find_movie, only: [:checkout, :checkin]

  def checkout
    unless Movie.checkout_inventory(@movie)
      render json: { errors: ["There are no copies of movie #{@movie.id} avaibale"] }, status: :bad_request
      return
    end

    rental = Rental.new(movie_id: @movie.id, customer_id: @customer.id)
    cur_date = Date.today
    rental.checkout_date = cur_date
    rental.due_date = cur_date + 7
    successful = rental.save
    if successful
      render json: { id: rental.id }, status: :ok
    else
      render json: { errors: rental.errors.messages },
             status: :bad_request
    end
  end

  def checkin
    successful = Movie.checkin_inventory(@movie)

    if successful
      render json: { ok: "successfully checked in movie" }
    else
      render json: { errors: "this movie was not checked out" }
    end
  end

  private

  def find_movie
    movie_id = params[:movie_id]
    @movie = Movie.find_by(id: movie_id)
    unless @movie
      render json: { errors: ["The movie with id #{movie_id} was not found"] }, status: :not_found
    end
    return @movie
  end

  def find_customer
    customer_id = params[:customer_id]
    @customer = Customer.find_by(id: customer_id)
    unless @customer
      render json: { errors: ["The customer with id #{custoemr_id} was not found"] }, status: :not_found
    end
    return @customer
  end
end
