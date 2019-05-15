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
        post checkout_path, params: { rental: rental_info }
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
        post checkout_path, params: { movie_id: movie.id, customer_id: customers.first.id }
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)
      expect(body).must_include "errors"
      must_respond_with :bad_request
    end
  end
end
