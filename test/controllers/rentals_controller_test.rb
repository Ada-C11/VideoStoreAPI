require "test_helper"

describe RentalsController do
  let(:customer) { customers(:jessica) }
  let(:movie) { movies(:harrypotter) }
  let(:rental) { rentals(:one) }
  let(:rental_data) {
    {
      customer_id: customer.id,
      movie_id: movie.id,
    }
  }

  describe "check_out" do
    it "creates an instance of Rental given valid data" do
      expect {
        post check_out_path, params: rental_data
      }.must_change "Rental.count", 1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      rental = Rental.find(body["id"].to_i)

      expect(rental.movie).must_equal movie
      expect(rental.customer).must_equal customer
      expect(rental.checkout_date).must_equal Date.current
      expect(rental.due_date).must_equal Date.current + 7

      must_respond_with :success
    end

    it "returns an error if no params" do
      expect {
        post check_out_path
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      must_respond_with :bad_request
    end

    it "returns an error if no customer" do
      rental_data["customer_id"] = nil

      expect {
        post check_out_path, params: rental_data
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "customer"
      must_respond_with :bad_request
    end

    it "returns an error if no customer" do
      rental_data["customer_id"] = nil

      expect {
        post check_out_path, params: rental_data
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "customer"
      must_respond_with :bad_request
    end
  end

  describe "check_in" do 
    it "updates rental for valid request" do 
      expect {
        post check_in_path(rental.id)
      }.wont_change "Rental.count"

      rental.reload 
      expect(rental.checkin_date).must_equal Date.current
            
      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"
      must_respond_with :success
    end

    it "won't update rental for invalid rental id" do 
      expect { 
        post check_in_path(-1)
      }.wont_change "Rental.count"

      must_respond_with :not_found
    end
  end
end