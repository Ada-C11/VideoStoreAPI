class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies.as_json(only: [:id, :title, :release_date]), status: :ok
  end

  def show
  end

  def create
    movie = Movie.new(movie_params)
    movie.available_inventory = movie.inventory
    if movie.save
      render json: { id: movie.id }, status: :ok
    else
      render json: { errors: movie.errors.messages },
        status: :bad_request
    end
  end

  private

  def movie_params
    params.permit(:title, :overview, :release_date, :inventory)
  end
end
