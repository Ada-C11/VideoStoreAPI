class CustomersController < ApplicationController
  def index
    # customers = Customer.all.order(:name)
    if params[:sort] == "id"
      customers = Customer.all.order(:id)
    elsif params[:sort] == "name"
      customers = Customer.all.order(:name)
    else
      customers = Customer.all.order(:id)
    end

    render status: :ok, json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count])
  end

  private

  # def customer_params
  #   params.require(:customer).permit(:name, :registered_at, :address, :city, :state, :postal_code, :phone, :movies_checked_out_count)
  # end
end
