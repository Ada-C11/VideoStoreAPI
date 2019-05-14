class CustomersController < ApplicationController
  def index
    customers = Customer.all
    if !customers.empty?
      render json: customers.as_json(except: [:created_at, :updated_at]), status: :ok
    else
      render json: { message: "There are currently no customers." }
    end
  end
end
