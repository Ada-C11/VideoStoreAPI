class MoviesController < ApplicationController
  def zomg
    render json: { ready_for_lunch: "It works" }
  end
end
