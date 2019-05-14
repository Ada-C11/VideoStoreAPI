class CustomersController < ApplicationController
  def index
    customers = Customer.all
    #once we added foreign key movie checkout count, we will need to update the controller test
    render status: :ok, json: customers.as_json(only: [:id, :name, :registered_at, :address, :city, :state, :postal_code, :phone])
  end
end
