class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id])
    if movie
      render json: movie.as_json(except: [:created_at, :updated_at]), status: :ok
    else
      render json: { error: "This movie was not found" }, status: :not_found
    end
  end

  def create
    movie = movie.new(movie_params)
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
