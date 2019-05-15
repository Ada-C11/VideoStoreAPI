class CustomersController < ApplicationController
  def index
<<<<<<< HEAD
    customers = Customer.all.map { |customer| customer.as_json(only: [:name, :registered_at, :address, :city, :state, :postal_code, :phone]).merge({ "movies_checked_out_count": customer.checked_out_count }) }
    render status: :ok, json: customers.as_json
=======
    customers = Customer.all
    render status: :ok, json: customers.as_json(only: [:id, :name, :registered_at, :address, :city, :state, :postal_code, :phone])
>>>>>>> 864e9ad3f43c946e11c84b031389090cfec51ad8
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :registered_at, :address, :city, :state, :postal_code, :phone)
  end
end
