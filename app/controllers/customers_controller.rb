class CustomersController < ApplicationController
  def index
    if params[:sort]
      customers = Customer.all.order(params[:sort])
    else
      customers = Customer.all.order(:id)
    end

    render status: :ok, json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count])
  end

  private
end
