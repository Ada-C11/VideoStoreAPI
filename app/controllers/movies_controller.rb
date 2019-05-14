class MoviesController < ApplicationController
  def zomg
    render json: {ready_for_lunch: "It works"}
  end

  def index
    params[:sort] ? movies = Movie.order(params[:sort]) : movies = Movie.all

    render json: movies.as_json, status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie.nil?
      render json: {
        errors: "Movie not found.",
      }, status: :not_found
    else
      render json: {
        title: movie.title,
        overview: movie.overview,
        release_date: movie.release_date,
        inventory: movie.inventory,
      }, status: :ok
    end
  end

  private

  def movie_params
    params.permit(:title, :overview, :release_date, :inventory)
  end
end
