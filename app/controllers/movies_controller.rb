class MoviesController < ApplicationController

    def index
        movies = Movie.all
        render json:  movies.as_json(only: [:id, :title, :release_date]), status: :ok
    end

    def show
        movie = Movie.find_by(id: params[:id])
        if movie
            render json:  movie.as_json(only: [:id, :title, :overview, :release_date, :inventory, :available_inventory]), status: :ok
        else
            render json: {
                ok: false,
                messages: ["Movie not found"]
            },
            status: :bad_request
        end

    end
    
    def create
        movie = Movie.new(movie_params)
        if movie.save
            render json: movie.as_json(only: [:id, :title, :overview, :release_date, :inventory]),
                status: :ok
        else
            render json: {
                    ok: false,
                    errors: movie.errors.messages,
                },
                status: :bad_request
        end
    end

    def checkout
        rental = Rental.new(rental_params)
        puts "VVVVVVVVVVV"
        puts "CHECKOUT METHOD"
        # decrease movie inventory
        movie_id = params[:id]
        movie = Movie.find_by(id: movie_id)
        puts "VVVVVVVVVVV"
        puts "#{movie}"
        movie.update(inventory: movie.inventory - 1)

        # save rental
        if rental.save
            render json: rental.as_json(only: [rental_params]), status: :ok
        else
            render json: {
                    ok: false,
                    errors: rental.errors.messages,
                },
                status: :bad_request
        end
    end

    # def checkin
    #     rental = Rental.find_by(movie_id: rental_params[movie.id], customer_id: rental_params[customer_id])

    #     movie.update(inventory: movie.inventory + 1)
    #     rental.update(checkout_date: nil, due_date: nil, currently_checked_out: false)

    #     if rental.save
    #         render json: rental.as_json(only: [:movie_id, :customer_id]), status: :ok
    #     else
    #         render json: {
    #                 ok: false,
    #                 errors: rental.erros.messages,
    #             },
    #             status: :bad_request
    #     end
    # end

    private

    def movie_params
        params.permit(:title, :overview, :release_date, :inventory)
    end

    def rental_params
        params.permit(:movie_id, :customer_id)
    end

end
