class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies.as_json(only: [:id, :title, :release_date]), status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie #if movie is not nil
      render json: movie.as_json(only: [:id, :inventory, :overview, :title, :release_date]), status: :ok
    else
      render json: {ok: false, errors: "Movie not found"}, status: :not_found
    end
  end

  def create
    movie = Movie.new(movie_params)

    if movie.save #is successful
      render json: movie.as_json(only: [:id, :overview, :title, :release_date]), status: :ok #include id so they can find pet later if they want to
    else
      render json: {ok: false, errors: movie.errors.messages}, status: :bad_request
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :overview, :release_date, :inventory)
  end
end
