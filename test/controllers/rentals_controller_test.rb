require "test_helper"
require "pry"
describe RentalsController do
  let (:customer) { customers(:one) }
  let (:movie) { movies(:one) }
  let (:rental) {
    Rental.new(customer.id, movie.id)
  }

  let(:rental_params) {
    {
      customer_id: customers(:one).id,
      movie_id: movies(:one).id,
    }
  }

  describe "checkout" do
    it "checkout path is a working route and returns JSON" do
      post checkout_path params: rental_params
      expect(response.header["Content-Type"]).must_include "json"
      must_respond_with :success
    end

    it "checkout works with valid data" do
      expect { post checkout_path, params: rental_params }.must_change "Rental.count", 1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      rental = Rental.find_by(id: body["id"].to_i)

      expect(rental.customer_id).must_equal rental_params[:customer_id]
      expect(rental.movie_id).must_equal rental_params[:movie_id]
      expect(rental.checkout_date).must_equal Date.today
      expect(rental.due_date).must_equal Date.today + 7
      must_respond_with :success
    end

    it "checkout does not work with invalid data" do
      rental_params[:customer_id] = -1

      expect {
        post checkout_path, params: rental_params
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body["errors"]).must_include "customer"
      must_respond_with :bad_request
    end
  end

  describe "check-in" do
    let(:checkin_params) {
      { customer_id: customer.id,
       movie_id: movie.id }
    }

    let(:bad_checkin_params) {
      { customer_id: -1,
       movie_id: -1 }
    }

    it "a valid rental will return success and json" do
      post checkin_path, params: checkin_params
      must_respond_with :success
    end

    it "a valid rental decreases customers movies checked out count" do
      checkout_count = customer.movies_checked_out_count
      post checkin_path, params: checkin_params
      customer.reload
      expect(customer.movies_checked_out_count).must_equal checkout_count - 1
    end

    it "a valid rental increases the movies available inventory count" do
      available_inventory = movie.available_inventory
      post checkin_path, params: checkin_params
      movie.reload
      expect(movie.available_inventory).must_equal available_inventory + 1
    end

    it "returns 404 if rental not found" do
      post checkin_path, params: bad_checkin_params
      must_respond_with :not_found
    end

    it "an invalid rental will not decrease customers movies checked out count" do
      checkout_count = customer.movies_checked_out_count
      post checkin_path, params: bad_checkin_params
      customer.reload
      expect(customer.movies_checked_out_count).must_equal checkout_count
    end

    it "an invalid rental will not increase the movies available inventory count" do
      available_inventory = movie.available_inventory
      post checkin_path, params: bad_checkin_params
      movie.reload
      expect(movie.available_inventory).must_equal available_inventory
    end
  end
end
