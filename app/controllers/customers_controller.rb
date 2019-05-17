class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render status: :ok, json: customers.as_json(only: [:name, :id, :registered_at, :postal_code, :phone, :movies_checked_out_count])
  end
end
