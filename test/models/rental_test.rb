require "test_helper"
require "pry"

describe Rental do
  let(:rental) { Rental.new }

  describe "validations" do
    it "due date is today + 7 days" do
      movie = movies(:two)
      customer = customers(:two)
      rental_params = {movie_id: movie.id, customer_id: customer.id}
      # binding.pry

      post rentals_checkout_path
      rental = Rental.last
      rental.due_date.must_equal Date.today + 7
    end

    it "checkout_date is today" do
      movie = movies(:two)
      customer = customers(:two)
      rental_params = {movie_id: movie.id, customer_id: customer.id}
      # binding.pry

      post rentals_checkout_path
      rental = Rental.last
      rental.checkout_date.must_equal Date.today
    end
  end

  describe "relations" do
    it "belongs_to movie" do
    end

    it "belongs_to customer" do
    end
  end
end
