class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies.as_json(only: [:id, :release_date, :title]), status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id])
    if movie
      render json: movie.as_json(only: [:id, :inventory, :overview, :release_date, :title]),
             status: :ok
    else
      render json: {ok: false, errors: {movie: ["Movie not found"]}},
             status: :not_found
    end
  end

  def create
    movie = Movie.new(movie_params)
    is_successful = movie.save
    if is_successful
      render json: movie.as_json(only: [:id, :inventory, :overview, :release_date, :title]), status: :ok
    else
      render json: {ok: false, errors: movie.errors.messages}, status: :bad_request
    end
  end

  def checkout
    rental = Rental.new(rental_params)
    rental.checkout_date = Date.today
    rental.due_date = rental.checkout_date + 7.days
    rental.currently_checked_out = true

    is_successful = rental.save
    if is_successful
      render json: rental.as_json(only: [:due_date]), status: :ok
    else
      render json: {ok: false, errors: rental.errors.messages}, status: :bad_request
    end
  end

  def checkin
    rental = Rental.find_by(movie_id: rental_params[:movie_id], customer_id: rental_params[:customer_id])
    if rental
      rental.currently_checked_out = false

      is_successful = rental.save

      if is_successful
        render json: {ok: true, message: "successfully checked in!"}, status: :ok
      else
        render json: {ok: false, errors: rental.errors.messages}, status: :bad_request
      end
    else
      render json: {ok: false, errors: {rental: ["Rental not found"]}}, status: :not_found
    end
  end

  private

  def movie_params
    params.permit(:inventory, :overview, :release_date, :title)
  end

  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
