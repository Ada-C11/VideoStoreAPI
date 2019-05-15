class MoviesController < ApplicationController
  def index
    movies = Movie.all

    render status: :ok, json: movies.as_json(only: [:id, :title, :release_date, :overview, :inventory, :available_inventory])
  end

  def show
    movie = Movie.find_by(id: params[:id])

    render status: :ok, json: movie.as_json(only: [:id, :title, :release_date, :overview, :inventory, :available_inventory])
  end

  def zomg
    render json: { message: "It works!" }
  end
end
