require "test_helper"

describe RentalsController do
  describe "checkin" do
    before do
      @rental = rentals(:one)
      @rental_params = { movie_id: @rental.movie_id, customer_id: @rental.customer_id }
      @customer = Customer.find_by(id: @rental.customer_id)
      @movie = Movie.find_by(id: @rental.movie_id)
    end

    it "decrements customer's checked_out_count" do
      post checkin_path, params: @rental_params

      expect
    end
  end
end
