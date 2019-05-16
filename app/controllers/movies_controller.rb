class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render status: :ok, json: movies.as_json(only: [:id, :title, :release_date])
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      render status: :ok, json: movie.as_json(only: [ :title, :overview, :release_date, :inventory, :available_inventory ])
    else
      render status: :bad_request, json: [{ error: "Unable to find movie" }]
    end
  end

  def create
    movie = Movie.new(movie_params)
    if movie.available_inventory.nil?
      movie.set_available_inventory
    end
    if movie.save
      render json: [{ id: movie.id }], status: :ok
    else
      render json: [{ errors: movie.errors.messages }],
        status: :bad_request
    end
  end

  private

  def movie_params
    params.permit(:title, :overview, :release_date, :inventory, :available_inventory)
  end
end
