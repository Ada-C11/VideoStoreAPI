class CustomersController < ApplicationController
  def index
    if params[:sort]
      customers = Customer.order(params[:sort])
    else
      customers = Customer.all
    end

    render status: :ok, json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count])
  end

  def show
    customer = Customer.find_by(id: params[:id])

    if customer
      render status: :ok, json: customer.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count])
    else
      render status: :not_found, json: { errors: { "name": ["Customer #{params[:id]} not found"] } }
    end
  end
end
