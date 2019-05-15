class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render status: :ok, json: customers.as_json(only: [:id, :name, :registered_at, :address, :city, :state, :postal_code, :phone])
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :registered_at, :address, :city, :state, :postal_code, :phone)
  end
end
