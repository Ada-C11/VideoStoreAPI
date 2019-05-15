require "test_helper"

describe RentalsController do
  describe "checkout" do
    let(:rental_data) {
      {
        customer_id: (customers(:customer_1).id),
        movie_id: (movies(:movie_2).id)
      }
    }

    it "creates a new rental given customer & movie IDs" do
      expect {
      post checkout_path, params: rental_data
    }.must_change "Rental.count", +1

      must_respond_with :success

      expect(response.header['Content-Type']).must_include 'json'

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "customer_id"
      expect(body).must_include "movie_id"

      rental = Rental.last

      expect(rental.customer_id).must_equal rental_data[:customer_id]
      expect(rental.movie_id).must_equal rental_data[:movie_id]
    end

    it "returns an error for rental made without customer id" do
      # arrange
      rental_data["customer_id"] = nil

      expect {
        post checkout_path, params: rental_data
      }.wont_change "Rental.count"

      must_respond_with :bad_request

      expect(response.header['Content-Type']).must_include 'json'

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "customer"
    end

    it "returns an error for rental made without movie id" do
      # arrange
      rental_data["movie_id"] = nil

      expect {
        post checkout_path, params: rental_data
      }.wont_change "Rental.count"

      must_respond_with :bad_request

      expect(response.header['Content-Type']).must_include 'json'

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "movie"
    end
  end
end
