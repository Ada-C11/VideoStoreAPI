class MoviesController < ApplicationController
  def index
  end

  def zomg
    render json: { message: "It works!" }
  end
end
