class MoviesController < ApplicationController
  def index
    movies = Movie.all
    if !movies.empty?
      render json: movies.as_json(except: [:created_at, :updated_at]), status: :ok
    else
      render json: {message: "There are currently no movies."}
      # Another syntax, below, returns a different data structure (hash with ok: true as one key-value pair and pet: pets.as... as another key-value pair; this second key-value pair is the same as what's returned above - an array of hashes)
      # render json: {ok: true, pet: pets.as_json(except: [:created_at, :updated_at])}
    end
  end

  def show
    movie = Movie.find_by(id: params[:id])
    if movie
      render json: movie.as_json(except: [:created_at, :updated_at]), status: :ok
    else
      render json: {error: "This movie was not found"}, status: :not_found
    end
  end

  def create
    movie = Movie.new(movie_params)
    if movie.save
      render json: {id: movie.id}, status: :ok
    else
      render json: {errors: movie.errors.messages},
        status: :bad_request
    end
  end

  private

  def movie_params
    params.permit(:title, :overview, :release_date, :inventory)
  end
end
