class CustomersController < ApplicationController
  def zomg
    zomg = ["it works!"]
    render json:zomg
  end
end
