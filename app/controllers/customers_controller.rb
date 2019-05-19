class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count]), status: :ok
  end

  def show
    customer = Customer.find_by(id: params[:id])
    if customer
      render status: :ok, json: customer.as_json(only: [:id, :name, :registered_at, :adress, :city, :state, :postal_code, :phone, :movies_checked_out_count]), status: :ok
    else
      render status: :not_found, json: { ok: false, messages: "Movie was not found!" }
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :registered_at, :postal_code, :phone, :movies_checked_out_count)
  end
end
