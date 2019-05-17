class CustomersController < ApplicationController
  def index
    if valid?(params)
      customers = Customer.paginate(page: params[:p], per_page: params[:n]).order(params[:sort])

      render status: :ok, json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count])
    else
      render status: :bad_request, json: { errors: { "query": ["#{params} not a valid query parameter"] } }
    end
  end

  def show
    customer = Customer.find_by(id: params[:id])

    if customer
      render status: :ok, json: customer.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count])
    else
      render status: :not_found, json: { errors: { "name": ["Customer #{params[:id]} not found"] } }
    end
  end

  private

  def valid?(params)
    sorts = ["name", "registered_at", "postal_code", nil]
    return false unless sorts.include?(params[:sort])

    unless params[:p].nil?
      begin Integer(params[:p]) 
      rescue ArgumentError
        return false       
      end
    end

    unless params[:n].nil?
      begin Integer(params[:n])
      rescue ArgumentError
        return false       
      end
    end

    true
  end
end
