class CustomersController < ApplicationController
  def index
    customers = Customer.all.map { |customer| customer.as_json(only: [:id, :name, :registered_at, :address, :city, :state, :postal_code, :phone]).merge({"movies_checked_out_count": customer.checked_out_count}) }
    render status: :ok, json: customers.as_json
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :registered_at, :address, :city, :state, :postal_code, :phone)
  end
end
