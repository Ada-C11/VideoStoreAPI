require "test_helper"

describe RentalsController do
<<<<<<< HEAD
  describe "checkin" do
    let(:customer) { customers(:customer_1) }
    let(:movie) { movies(:movie_1) }
    let(:check_in_params) {
      { customer_id: customer.id,
       movie_id: movie.id }
    }
    it "will return ok, response body is json & hash" do
      post checkin_path, params: check_in_params
      must_respond_with :ok
      expect(response["Content-Type"]).must_include "json"
      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body["status"]).must_equal "ok"
    end

    it "will decrease rental count" do
      expect {
        post checkin_path, params: check_in_params
      }.must_change "Rental.count", -1
    end

    it "will decrease customer movies_checked_out_count by 1" do
      intitial = customer.movies_checked_out_count
      post checkin_path, params: check_in_params
      customer.reload
      expect(customer.movies_checked_out_count).must_equal intitial - 1
    end

    it "will increase movie available inventory" do
      intitial = movie.available_inventory
      post checkin_path, params: check_in_params
      movie.reload
      expect(movie.available_inventory).must_equal intitial + 1
    end

    it "will return 404 if invalid rental params sent and not change rentals, movies, or customers" do
      intitial_movie = movie.available_inventory
      intitial_cust = customer.movies_checked_out_count
      expect {
        post checkin_path, params: { customer_id: -1,
                                    movie_id: movie.id }
      }.wont_change "Rental.count"

      customer.reload
      movie.reload
      expect(movie.available_inventory).must_equal intitial_movie

      must_respond_with :not_found

      expect(response["Content-Type"]).must_include "json"
      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body["errors"]).must_equal "rental"=>["Rental not found for customer ID -1, and movie ID 485665370"]
=======
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
>>>>>>> a8fb87d7b6d875a67516980b4294cafbf56ce4ea
    end
  end
end
