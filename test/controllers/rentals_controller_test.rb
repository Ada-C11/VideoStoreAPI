require "test_helper"

describe RentalsController do
  describe "check_in" do
    let(:customer) { customers(:customer1) }
    let(:movie) { movies(:movie1) }
    let(:rental_params) {
      {
        movie_id: movie.id,
        customer_id: customer.id,
      }
    }

    it "should check-in a movie given valid data" do
      inventory = movie.inventory

      expect {
        post check_in_path(rental_params)
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)
      movie.reload

      must_respond_with :success
      expect(body).must_be_kind_of Hash
      expect(body.keys).must_include "check_in_date"
      expect(body["check_in_date"]).must_equal Date.current.to_s
      expect(movie.inventory).must_equal inventory + 1
    end

    it "responds with bad request given invalid data" do
      inventory = movie.inventory
      rental_params[:customer_id] = nil

      expect {
        post check_in_path(rental_params)
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)
      movie.reload

      must_respond_with :bad_request
      expect(body).must_be_kind_of Hash
      expect(body.keys).must_include "errors"
      expect(body["errors"]).must_equal ["Rental not found"]
      expect(movie.inventory).must_equal inventory
    end
  end
end
