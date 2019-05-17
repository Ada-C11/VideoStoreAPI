class CustomersController < ApplicationController
    def index
        customers = Customer.all 
        render status: :ok, json: customers.as_json(only: [:name, :phone, :postal_code, :registered_at, :id], methods: [:movies_checked_out_count])
    end 
    
    def zomg
        render json: { message: "it works!"},
        status: :ok
    end 
end
