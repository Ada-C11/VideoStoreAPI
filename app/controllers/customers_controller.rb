class CustomersController < ApplicationController
  def index
    list = Customer.all

    render json: format_json(list), status: :ok
  end

  private

  def format_json(customer_data)
    return customer_data.as_json(only: [:id, :name, :registered_at, :address, :city, :state, :postal_code, :phone, :movies_checked_out_count])
  end
end
