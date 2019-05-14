require "test_helper"
require "pry"

describe RentalsController do
  describe "checkin" do
    before do
      @rental = rentals(:one)
      @rental_params = { rental: { movie_id: @rental.movie_id, customer_id: @rental.customer_id } }
      @customer = Customer.find_by(id: @rental.customer_id)
      @movie = Movie.find_by(id: @rental.movie_id)
    end

    it "decrements customer's checked_out_count" do
      old_customer_value = @customer.movies_checked_out_count
      old_movie_value = @movie.available_inventory
      post checkin_path, params: @rental_params
      @customer.reload
      @movie.reload
      expect(@customer.movies_checked_out_count).must_equal old_customer_value - 1
      expect(@movie.available_inventory).must_equal old_movie_value + 1
    end
  end

  describe "checkout" do
    let(:rental_data) do
      { rental: {
        customer_id: customers(:joe).id,
        movie_id: movies(:one).id,
      } }
    end
    it "must create a new rental" do
      expect {
        post checkout_path, params: rental_data
      }.must_change "Rental.count"
    end

    it "must change the available_inventory of the checkout out movie" do
    end
  end
end
