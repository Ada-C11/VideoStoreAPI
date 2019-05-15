class RentalsController < ApplicationController

    def checkin
        movie = Movie.find_by(id: params[:id])
        customer = Customer.find_by(id: params[:id])
        rental = Rental.new(customer.id, movie.id)

        if rental.save
            movie.update(inventory: movie.inventory + 1) 
            render json: rental.as_json(only:[:id :movie_id, :customer_id]) status: :ok
        else
            render json: {
                ok: false,
                errors: [rental.erros.messages]
            }
            status: :bad_request
        end
    end

    private

    def rental_params
        params.require.permit(:movie, :customer)
    end
    
end




