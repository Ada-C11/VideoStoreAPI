class MoviesController < ApplicationController
  def zomg
    render json: {ready_for_lunch: "It works"}
  end

  def index
    params[:sort] ? movies = Movie.order(params[:sort]) : movies = Movie.all

    render json: movies.as_json, status: :ok
  end
end
