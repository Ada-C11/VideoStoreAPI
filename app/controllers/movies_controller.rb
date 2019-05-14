class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies.as_json(only: [:id, :release_date, :title]), status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      render status: :ok, json: movie.as_json(only: [:inventory, :overview, :release_date, :title])
    else
      render status: :not_found, json: {errors: ["The movie you are looking for cannot be found."]}
    end
  end
end
