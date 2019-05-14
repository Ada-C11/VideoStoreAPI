class MoviesController < ApplicationController
  def show
    movie = Movie.find_by(id: params[:id])
    if movie
      render json: movie.as_json(only: [:id, :inventory, :overview, :release_date, :title]),
             status: :ok
    else
      render json: { ok: false, errors: { movie: ["Movie not found"] } },
             status: :not_found
    end
  end
end
