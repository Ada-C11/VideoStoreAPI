class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies.as_json(only: [:available_inventory, :id, :title, :inventory, :overview, :release_date]), status: :ok
  end

  def create
    movie = Movie.new(movie_params)
    movie.available_inventory = movie.inventory

    if movie.save
      render json: movie.as_json(only: [:id]),
             status: :ok
    else
      render json: { errors: ["Movie could not be saved"] },
             status: :bad_request
    end
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      render json: movie.as_json(only: [:available_inventory, :id, :title, :inventory, :overview, :release_date]), status: :ok
    else
      render json: { errors: ["The movie with id #{params[:id]} could not be found"] }, status: :not_found
    end
  end

  private

  def movie_params
    params.permit(:title, :inventory, :overview, :release_date)
  end
end
