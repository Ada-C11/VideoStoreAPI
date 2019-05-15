require "test_helper"

describe RentalsController do
  describe "Checkin" do
    let(:movie) { movies(:one) }
    let(:customer) { customers(:one) }
    let(:rental_data) {
      {
        movie_id: movie.id,
        customer_id: customer.id,
      }
    }
    it "should pass given valid data" do
      post checkin_path, params: {rental: rental_data}

      value(response).must_be :success?
      expect(response.header["Content-Type"]).must_include "json"

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      rental = Rental.find(body["id"].to_i)

      expect(rental.customer_id).must_equal rental_data[:customer.id]
      expect(rental.movie_id).must_equal rental_data[:movie.id]
    end

    it "throws an error and returns BAD REQUEST if given invalid data" do
      rental_data["customer_id"] = -1

      post checkin_path, params: {rental: rental_data}

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "customer_id"
      must_respond_with :bad_request
    end
  end
end
