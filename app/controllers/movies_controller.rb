class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render status: :ok, json: movies.as_json(only: [:title, :overview, :release_date, :inventory])
  end

  def show
    movie = Movie.find_by(id: params[:id])
    if movie
      render status: :ok, json: movie.as_json(only: [:title, :overview, :release_date, :inventory]).merge({ "available_inventory": movie.number_available })
    else
      render status: :not_found, json: { errors: [id: "The movie you are looking for with id #{params[:id]}  was not found"] }
    end
  end

  def create
    movie = movie.new(movie_params)
    if movie.save
      render status: :ok, json: movie.as_json(only: [:title, :overview, :release_date, :inventory]).merge({ "available_inventory": movie.number_available })
    else
      render status: :bad_request, json: { errors: movie.errors.messages }
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :overview, :release_date, :inventory)
  end
end
