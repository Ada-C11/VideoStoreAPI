class MoviesController < ApplicationController
  def show
    movie = Movie.find_by(id: params[:id])
    if movie
      render json: movie.as_json(only: [:title, :overview, :release_date, :inventory, :available_inventory]), status: :ok
    else
      render status: :not_found, json: { "errors": movie.errors.messages }
    end
  end
end
