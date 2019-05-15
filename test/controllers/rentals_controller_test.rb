require "test_helper"

describe RentalsController do
  describe "checkout" do
    let(:rental_data) {
      {
        movie_id: movies(:one).movie_id,
        customer_id: customers(:one).id,
      }
    }

    it "can create a new rental provided valid data" do
      expect {
        post rental_path, params: rental_data
      }.must_change "Rental.count", +1

      new_rental = Rental.last

      must_respond_with :success

      body = JSON.parse(response.body)
      expet(body).must_be_kind_of Hash
    end

    it "won't create new rental with invalid customer" do
      rental_data["customer_id"] = -7

      expect {
        post rental_path, params: rental_data
      }.wont_change "Rental.count"

      must_respond_with :bad_request
    end

    it "won't create new rental with invalid movie" do
      rental_data["movie_id"] = -7

      expect {
        post rental_path, params: rental_data
      }.wont_change "Rental.count"

      must_respond_with :bad_request
    end
  end
end
