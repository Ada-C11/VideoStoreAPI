require "test_helper"

describe RentalsController do
  let(:customer) { customers(:two) }
  let(:movie) { movies(:one) }
  describe "check-out" do
    let(:rental_data) {
      {
        customer_id: customer.id,
        movie_id: movie.id,
      }
    }
    it "should create a new rental given correct information" do
      movie_inventory = movie.available_inventory
      customer_checked_out_count = customer.movies_checked_out_count

      expect {
        post check_out_path, params: rental_data
      }.must_change "Rental.count", 1

      rental = Rental.find_by(customer_id: customer.id, movie_id: movie.id)

      expect(rental.movie.available_inventory).must_equal movie_inventory - 1
      expect(rental.customer.movies_checked_out_count).must_equal customer_checked_out_count + 1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      json_rental = Rental.find(body["id"].to_i)

      expect(json_rental.customer_id).must_equal rental_data[:customer_id]
      expect(json_rental.movie_id).must_equal rental_data[:movie_id]
      must_respond_with :success
    end

    it "should send a 404 if given bad information" do
      rental_data[:customer_id] = nil

      expect {
        post check_out_path, params: rental_data
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "customer"
      must_respond_with :bad_request
    end

    it "will return an error if a movie has no available_inventory" do
      movie.available_inventory = 0
      movie.save

      expect {
        post check_out_path, params: rental_data
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "error_message"
      expect(body["error_message"]).must_include "No available inventory"
      must_respond_with :bad_request
    end
  end
end
