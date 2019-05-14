class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render status: :ok, json: movies.as_json(only: [:id, :title, :release_date])
  end

  private

  def movie_params
    return params.require(:movie).permits(:title, :overview, :release_date, :inventory)
  end
end
