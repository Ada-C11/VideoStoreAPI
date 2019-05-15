# frozen_string_literal: true

class MoviesController < ApplicationController
  def zomg
    render json: { message: 'it works!' }
  end

  def index
    if valid?(params)
      movies = Movie.paginate(page: params[:p], per_page: params[:n]).order(params[:sort])
      render json: movies.as_json(only: %i[id title release_date])
    else
      render json: { ok: false, message: 'Query params not valid' }, status: :not_found
    end
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      render json: movie.as_json(only: %i[title overview release_date inventory available_inventory]), status: :ok
    else
      render json: { ok: false, message: 'Movie not found' }, status: :not_found
    end
  end

  def create
    movie = Movie.new(movie_params)
    movie.available_inventory = movie.inventory

    if movie.save
      render json: movie.as_json(only: %i[title overview release_date inventory id available_inventory]), status: :ok
    else
      render json: { ok: false, message: movie.errors.messages }, status: :bad_request
    end
  end

  private

  def valid?(params)
    sorts = ['title', 'release_date', nil]
    return false unless sorts.include?(params[:sort])

    unless params[:p].nil?
      begin Integer(params[:p])
      rescue ArgumentError
        return false
      end
    end

    unless params[:n].nil?
      begin Integer(params[:n])
      rescue ArgumentError
        return false
      end
    end

    true
  end

  def movie_params
    params.require(:movie).permit(:title, :overview, :release_date, :inventory, :available_inventory)
  end
end
