# frozen_string_literal: true

class MoviesController < ApplicationController
  def zomg
    render json: { message: "it works!" }
  end

  def index
    movies = Movie.all
    render json: movies.as_json(only: [:id, :title, :release_date])
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      render json: movie.as_json(only: %i[title overview release_date inventory]), status: :ok
    else
      render json: { ok: false, message: "Movie not found" }, status: :not_found
    end
  end

  def create
    movie = Movie.new(movie_params)
    movie.available_inventory = movie.inventory

    if movie.save
      render json: movie.as_json(only: %i[title overview release_date inventory id]), status: :ok
    else
      render json: { ok: false, message: movie.errors.messages }, status: :bad_request
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :overview, :release_date, :inventory)
  end
end
