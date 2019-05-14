require "test_helper"
require 'pry'

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
  describe "checkout" do
    let(:rental_data) do
      { rental:
        {
          customer_id: customers(:joe).id,
          movie_id: movies(:one).id
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
