class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies.as_json(only: [:id, :title, :release_date]), status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id])
    if movie
      render json: movie.as_json(only: [:id, :title, :release_date, :available_inventory, :inventory, :overview]), status: :ok
    else
      render json: ["wrong info"], status: ok
    end
  end
end
