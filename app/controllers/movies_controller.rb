
class MoviesController < ApplicationController

  def index
    if params[:sort]== "title" || params[:sort]== "release_date" && params[:n]
      movies = Movie.all.order(params[:sort]).paginate(page: params[:p], per_page: params[:n])
    elsif params[:sort] == "title" || params[:sort]== "release_date" 
        movies = Movie.all.order(params[:sort])
    elsif params[:n] && params[:p]
        movies = Movie.all.paginate(page: params[:p], per_page: params[:n])
    else
      movies = Movie.all
    end
    render json: movies.as_json(only: [:id, :title, :release_date]), status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie #if movie is not nil
      render json: movie.as_json(only: [:id, :inventory, :overview, :title, :release_date, :available_inventory]), status: :ok
    else
      render json: {ok: false, errors: "Movie not found"}, status: :not_found
    end
  end

  def create
    movie = Movie.new(movie_params)

    if movie.save #is successful
      movie.available_inventory = movie.inventory
      movie.save
      render json: movie.as_json(only: [:id, :overview, :title, :release_date, :inventory, :available_inventory]), status: :ok #include id so they can find pet later if they want to
    else
      render json: {ok: false, errors: movie.errors.messages}, status: :bad_request
    end
  end

  private

  def movie_params
    params.permit(:title, :overview, :release_date, :inventory)
  end
end
