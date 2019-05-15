class MoviesController < ApplicationController
  def index
    movies = Movie.all

    render status: :ok, json: movies.as_json(only: [:id, :title, :release_date, :overview, :inventory, :available_inventory])
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if !movie.nil?
      render status: :ok, json: movie.as_json(only: [:id, :title, :release_date, :overview, :inventory, :available_inventory])
    else
      render json: { ok: false, message: "Movie not found" }, status: :not_found
    end
  end

  def zomg
    render json: { message: "It works!" }
  end

  private

  def movie_params
    params.permit(:title, :release_date, :overview, :inventory)
  end
end
