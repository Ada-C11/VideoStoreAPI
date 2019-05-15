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

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      rental = Rental.find(body["id"].to_i)

      expect(rental.movie_id).must_equal rental_info[:movie_id]
      expect(rental.customer_id).must_equal rental_info[:customer_id]
    end

    it "creates a rental with the correct checkout and due date" do
      post checkout_path, params: rental_info

      body = JSON.parse(response.body)
      rental = Rental.find(body["id"].to_i)

      cur_date = Date.today

      expect(rental.checkout_date).must_equal cur_date
      expect(rental.due_date).must_equal cur_date + 7
    end

    it "returns an error if given an invalid movie or customer id" do
      rental_info[:movie_id] = "invalid"

      expect {
        post checkout_path, params: {rental: rental_info}
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      must_respond_with :not_found
    end

    it "will respond with bad_request if the movie has no available inventory" do
      movie = movies.first
      movie.available_inventory = 0
      movie.save

      expect {
        post checkout_path, params: {movie_id: movie.id, customer_id: customers.first.id}
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)
      expect(movie.available_inventory).must_equal 0
      expect(body).must_include "errors"
      must_respond_with :bad_request
    end
  end

  describe "checkin" do
    let(:movie) { movies(:one) }
    let(:customer) { customers(:one) }
    let(:rental_info) {
      {
        movie_id: movie.id,
        customer_id: customer.id,
      }
    }

    it "successfully checkin a movie when there are copies of the movie checked out and the customer has checked out an movie" do
      start_count_inventory = movie.available_inventory
      start_checked_out_count = customer.movies_checked_out_count

      post checkin_path, params: rental_info

      body = JSON.parse(response.body)
      movie.reload
      customer.reload

      expect(movie.available_inventory).must_equal start_count_inventory + 1
      expect(customer.movies_checked_out_count).must_equal start_checked_out_count - 1
      expect(body["ok"]).must_include "Successfully checked in movie"
      must_respond_with :ok
    end

    it "will return an error if the movie is not checked out or the customer's movies has not checked out any movie" do
      movie.available_inventory = 0
      movie.save
      customer.movies_checked_out_count = 0
      customer.save

      post checkin_path, params: rental_info

      body = JSON.parse(response.body)
      movie.reload
      customer.reload

      expect(movie.available_inventory).must_equal 0
      expect(customer.movies_checked_out_count).must_equal 0
      expect(body["errors"]).must_include "This movie has not been checked out"
      must_respond_with :bad_request
    end
  end
end
