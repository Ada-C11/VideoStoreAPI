class RentalsController < ApplicationController
  def checkout
  end

  def checkin
  end

  private

  def rental_params
    params.require(:rental).permit(:movie_id, :customer_id)
  end
end
