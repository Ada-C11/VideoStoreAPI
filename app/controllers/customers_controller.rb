class CustomersController < ApplicationController
  def index
    customers = Customer.all

    render json: customers.as_json(:methods => [:movies_checked_out_count], except: [:created_at, :updated_at]),
           status: :ok
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :registered_at, :address, :city, :state, :postal_code, :phone)
  end
end
