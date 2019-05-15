class CustomersController < ApplicationController
  def index
    
    if params[:sort] && params[:n]
      customers = Customer.all.order(params[:sort]).paginate(page: params[:p], per_page: params[:n])
    elsif params[:sort]
        customers = Customer.all.order(params[:sort])
    elsif params[:n] && params[:p]
        customers = Customer.all.paginate(page: params[:p], per_page: params[:n])
    else
      customers = Customer.all
    end

    render status: :ok, json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count])
  end

  private
end
