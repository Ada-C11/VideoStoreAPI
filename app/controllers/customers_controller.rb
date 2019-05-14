class CustomersController < ApplicationController
  def index
    customers = Customer.all

    render status: :ok, json: customers.as_json(only: [:name, :registered_at, :phone, :id])
  end
end
