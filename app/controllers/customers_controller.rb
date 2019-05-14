class CustomersController < ApplicationController
  def zomg
    render json: { :zomg => "it works"}
  end 
end
