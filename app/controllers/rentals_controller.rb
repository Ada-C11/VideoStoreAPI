class RentalsController < ApplicationController
  def checkout
    movie = Movie.find_by(id: params[:movie_id])
    customer = Customer.find_by(id: params[:customer_id])
    rental = Rental.new(customer_id: params[:customer_id], movie_id: params[:movie_id], checkout_date: Date.today, due_date: Date.today + 7)

    if movie.available_inventory == 0
      render json: {ok: false, errors: "Movie is out of stock"}, status: :bad_request
    elsif rental.save
      customer.movies_checked_out_count += 1
      customer.save
      movie.available_inventory -= 1
      movie.save
      rental.title = movie.title
      rental.name = customer.name
      rental.postal_code = customer.postal_code
      render json: rental.as_json(only: [:customer_id, :movie_id, :checkout_date, :due_date, :id]), status: :ok
    else
      render json: {ok: false, errors: rental.errors.messages}, status: :bad_request
    end
  end

  def checkin
    rental = Rental.find_by(customer_id: params[:customer_id], movie_id: params[:movie_id])
    if rental
      customer = Customer.find_by(id: params[:customer_id])
      customer.movies_checked_out_count -= 1
      customer.save
      movie = Movie.find_by(id: params[:movie_id])
      movie.available_inventory += 1
      movie.save
      render json: {ok: true, messages: "Rental checked in successfully"}, status: :ok
    else
      render json: {ok: false, errors: "Rental not found"}, status: :bad_request
    end
  end

  def overdue
    rentals = Rental.all
    overdue_rentals = []

    if rentals == []
      return render json: {ok: false, errors: "No rentals"}, status: :bad_request
    end

    rentals.each do |rental|
      if rental.due_date < Date.today
        overdue_rentals << rental
      end
    end
    render json: overdue_rentals.as_json(only: [:customer_id, :name, :postal_code, :movie_id, :title, :checkout_date, :due_date])
  end
end
