class MoviesController < ApplicationController

    def index
        movies = Movie.all
        render json:  movies.as_json(only: [:id, :title, :release_date]), status: :ok
    end

    def show
        movie = Movie.find_by(id: params[:id])
        if movie
            render json:  movie.as_json(only: [:id, :title, :overview, :release_date, :inventory], methods: [:available_inventory]), status: :ok
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

        rental.set_checkout_date

        checkout_successful = rental.save

        if checkout_successful
            render json: rental.as_json(only: [:id]), status: :ok
        else
            render json: {
            ok: false,
            errors: rental.errors.messages,
            },
            status: :bad_request
        end
    end

    def checkin
        rental = Rental.find_by(movie_id: rental_params[:movie_id], customer_id: rental_params[:customer_id])

        rental.set_checkin_date

        checkin_successful = rental.save

        if checkin_successful
            render json: rental.as_json(only: [:id]), status: :ok
        else
            render json: {
            ok: false,
            errors: rental.errors.messages,
            },
            status: :bad_request
            return
        end
    end

    private

    def movie_params
        params.permit(:id, :title, :overview, :release_date, :inventory)
    end

    def rental_params
        params.permit(:movie_id, :customer_id)
    end

end
