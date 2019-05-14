class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render status: :ok, json: movies.as_json(only: [:id, :title, :overview, :release_date, :inventory])
  end

  def show
    id = params[:id]
    movie = Movie.find_by(id: id)
    if movie
      render json: movie.as_json(only: [:id, :title, :overview, :release_date, :inventory]), status: :ok
    else
      render json: {errors: ["The movie with id #{id} was not found"]}, status: :not_found
    end
  end

  def create
    movie = Movie.new(movie_params)

    if movie.save
      render json: { id: movie.id }, status: :ok
    else
      render json: { errors: movie.errors.messages },
             status: :bad_request
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :overview, :release_date, :inventory)
  end
end
