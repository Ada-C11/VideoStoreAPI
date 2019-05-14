class MoviesController < ApplicationController
  def index
    movies = Movie.all

    render status: :ok, json: movies.as_json(only: [:title, :release_data, :overview, :inventory, :available_inventory])
  end

  def zomg
    render json: { message: "It works!" }
  end
end
