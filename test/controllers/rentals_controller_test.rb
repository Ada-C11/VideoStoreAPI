require "test_helper"

describe RentalsController do
  describe "checkout" do
    let(:rental_info) {
      {
        movie_id: movies.first.id,
        customer_id: customers.first.id,
      }
    }
    it "creates a new rental with valid data" do
      expect {
        post checkout_path, params: rental_info
      }.must_change "Rental.count", 1
    end

    it "creates a rental with the correct checkout and due date" do
    end

    it "returns an error if given an invalid movie or customer id" do
    end
  end
end
