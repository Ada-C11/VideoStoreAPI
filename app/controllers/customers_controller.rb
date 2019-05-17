class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render status: :ok, json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone])
  end
end
