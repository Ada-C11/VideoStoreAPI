class CustomersController < ApplicationController
    def zomg
        render json: {text: "It works"}
    end
end
