class RentalsController < ApplicationController
  def checkout

  end

  def checkin

  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
