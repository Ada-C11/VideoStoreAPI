require "test_helper"

describe RentalsController do
  
  describe "checkout" do
    let(:rental_data) {
      {
        customer_id: customers(:customer_one).id,
        movie_id: movies(:movie_one).id,
      }
    }

    it "creates a new rental given valid data" do
      expect {
        post checkout_path, params: rental_data
      }.must_change "Rental.count", 1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      rental = Rental.find(body["id"].to_i)

      expect(rental.customer_id).must_equal rental_data[:customer_id]
      must_respond_with :success
    end

    it "returns an error for invalid rental data" do
      # arrange
      rental_data["customer_id"] = nil

      expect {
      post checkout_path, params: rental_data
    }.wont_change "Rental.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "customer_id"
      must_respond_with :bad_request
    end
  end
end
