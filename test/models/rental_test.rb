require "test_helper"
require "pry"

describe Rental do
  describe "relations" do
    it "has a customer" do
      rental = rentals(:rental_one)
      rental.must_respond_to :customer
      rental.customer.must_be_kind_of Customer
    end

    it "has a movie" do
      rental = rentals(:rental_one)
      rental.must_respond_to :movie
      rental.movie.must_be_kind_of Movie
    end
  end

  describe "validations" do
    it "requires a customer_id" do
      rental = Rental.new(movie_id: movies(:movie_one).id, checkout_date: 2019 - 05 - 14, due_date: 2019 - 05 - 21)
      rental.valid?.must_equal false
      rental.errors.messages.must_include :customer_id
    end

    it "requires a movie_id" do
      rental = Rental.new(customer_id: customers(:customer_one).id, checkout_date: 2019 - 05 - 14, due_date: 2019 - 05 - 21)
      rental.valid?.must_equal false
      rental.errors.messages.must_include :movie_id
    end

    it "requires a checkout date" do
      rental = Rental.new(movie_id: movies(:movie_one).id, customer_id: customers(:customer_one).id, due_date: 2019 - 05 - 21)
      rental.valid?.must_equal false
      rental.errors.messages.must_include :checkout_date
    end

    it "requires a due date" do
      rental = Rental.new(movie_id: movies(:movie_one).id, customer_id: customers(:customer_one).id, checkout_date: 2019 - 05 - 14)
      rental.valid?.must_equal false
      rental.errors.messages.must_include :due_date
    end
  end
end
