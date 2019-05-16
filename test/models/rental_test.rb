require "test_helper"
require "pry"

describe Rental do
  let(:rental) { Rental.new }

  describe "validations" do
    #   # NOTE: THESE TESTS ARE DUPLICATED IN THE CONTROLLER TESTS, AND THEY DON'T WORK HERE. RENTALS_CHECKOUT_PATH IS UNDEFINED VARIABLE OR METHOD
    # it "due date is today + 7 days" do

    #   movie = movies(:GreenMile)
    #   customer = customers(:two)
    #   rental_params = {movie_id: movie.id, customer_id: customer.id}
    #   # binding.pry

    #   post rentals_checkout_path, params: rental_params
    #   rental = Rental.find_by(customer_id: customer.id, movie_id: movie.id)
    #   rental.due_date.must_equal Date.today + 7
    # end

    # it "checkout_date is today" do
    #   movie = movies(:GreenMile)
    #   customer = customers(:two)
    #   rental_params = {movie_id: movie.id, customer_id: customer.id}
    #   # binding.pry

    #   post rentals_checkout_path, params: rental_params
    #   rental = Rental.find_by(customer_id: customer.id, movie_id: movie.id)
    #   rental.checkout_date.must_equal Date.today
    # end
  end

  describe "relations" do
    it "belongs_to movie" do
      rental = rentals(:one)
      rental.movie.must_equal movies(:GreenMile)
    end

    it "belongs_to customer" do
      rental = rentals(:one)
      rental.customer.must_equal customers(:one)
    end
  end
end
