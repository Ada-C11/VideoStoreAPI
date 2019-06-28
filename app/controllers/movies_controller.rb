class MoviesController < ApplicationController
  def index
    movies = Movie.all

    render json: movies.as_json(only: [:id, :title, :release_date]),
           status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id])
    if !movie.nil?
      render json: movie.as_json(
               only: [:title, :overview, :release_date, :inventory, :available_inventory],
             ),
             status: :ok
    else
      render json: { ok: false, errors: "Movie not found" },
             status: :not_found
    end
  end

  def create
    movie = Movie.new(movie_params)
    movie.available_inventory = movie.inventory

    if movie.save
      render json: { ok: true, id: movie.id },
             status: :ok
    else
      render json: { ok: false, errors: movie.errors.messages },
        status: :bad_request
    end
  end

  private

  def movie_params
    params.permit(:title, :overview, :release_date, :inventory)
  end
end
