class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render status: :ok, json: movies.as_json(only: [:id, :title, :release_date])
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      render status: :ok, json: movie.as_json(only: [:title, :overview, :release_date, :inventory])
    else
      render status: :not_found, json: {errors: ["Movie with ID #{params[:id]} not found"]}
    end
  end

  def create
    movie = Movie.new(movie_params)

    if movie.save
      render status: :ok, json: {id: movie.id}
    else
      render status: :bad_request, json: {errors: movie.errors.messages}
    end
  end

  def zomg
    render json: {works: "it works!"}
  end

  private

  def movie_params
    params.permit(:title, :overview, :release_date, :inventory)
  end
end
