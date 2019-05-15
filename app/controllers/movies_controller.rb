class MoviesController < ApplicationController
  def show
    movie = Movie.find_by(id: params[:id])
    if movie
      render json: movie.as_json(only: [:id, :title, :release_date, :overview, :available_inventory, :inventory]), status: :ok
    else
      render status: :error, json: { errors: { id: "Movie does not exist" } }
    end
  end

  def index
    movies = Movie.all
    render status: :ok, json: movies.as_json(only: [:id, :title, :release_date])
  end

  def create
    movie = Movie.new(movie_params)

    if movie.save
      current_inventory = movie.inventory
      movie.update_attributes(available_inventory: current_inventory)
      render status: :ok, json: movie.as_json(only: [:id, :title, :release_date])
    else
      render status: :bad_request, json: { "errors": movie.errors.messages }
    end
  end

  private

  def movie_params
    return params.permit(:title, :overview, :release_date, :inventory, rental_ids: [])
  end
end
