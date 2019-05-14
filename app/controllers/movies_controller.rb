class MoviesController < ApplicationController
  def show
    movie = Movie.find_by(id: params[:id])
    if movie
      render json: movie.as_json(only: [:title, :overview, :release_date, :inventory, :available_inventory]), status: :ok
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
      render status: :ok, json: movie.as_json(only: [:id, :title, :release_date])
    else
      render status: :bad_request, json: { "errors": movie.errors.messages }
    end
  end

  private

  def movie_params
    return params.require(:movie).permit(:title, :overview, :release_date, :inventory, :available_inventory)
  end
end
