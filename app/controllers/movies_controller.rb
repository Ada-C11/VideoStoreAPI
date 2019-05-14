# frozen_string_literal: true

class MoviesController < ApplicationController
  def zomg
    render json: { message: "it works!" }
  end

  def index
    movies = Movie.all
    render json: movies.as_json(only: [:id, :title, :release_date])
  end

  def show; end

  def create; end
end
