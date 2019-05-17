class CustomersController < ApplicationController
  def index
    customer = Customer.all
    render json: customer.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count]), status: :ok
  end



  private

  def customer_params
    params.permit(:id, :name, :registered_at, :postal_code, :phone)
  end
end
