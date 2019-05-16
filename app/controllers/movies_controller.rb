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
        # find a movie by id 
        # movie = Movie.find_by(movie_id: movie_params[:movie_id])
        # create a rental
        rental = Rental.new(rental_params)

        # set checkout dates
        rental.set_checkout_date

        checkout_successful = rental.save
        
        
        # update movie inventory
        # movie.available_inventory
        
        # save rental
        if checkout_successful
            # render json if save is successful
            render json: rental.as_json(only: [:id]), status: :ok
        else
            render json: {
            ok: false,
            errors: rental.errors.messages,
            },
            status: :bad_request
        end
        # render error message if save is unsuccessful

        # movie = Movie.find_by(id: params[:movie_id])
        # rental = Rental.new(rental_params)

        # movie.available_inventory
        # rental.set_checkout_date

        # # save rental
        # is_successful = rental.save

        # if is_successful
        #     render json: rental.as_json(only: [rental_params]), status: :ok
        # else
        #     render json: {
        #             ok: false,
        #             errors: rental.errors.messages,
        #         },
        #         status: :bad_request
        # end
    end

    # def checkin
    #     # rental = Rental.find_by(movie_id: rental_params[movie.id], customer_id: rental_params[customer_id])

    #     # create a new rental
    #     rental = Rental.new(rental_params)

    #     # find movie
    #     movie_id = params[:movie_id]
    #     movie = Movie.find_by(id: movie_id)

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
        params.permit(:id, :title, :overview, :release_date, :inventory)
    end

    def rental_params
        params.permit(:movie_id, :customer_id)
    end

end
