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
end
