require "test_helper"
require "pry"

describe RentalsController do
  let(:rental_data) {
    {
      customer_id: customers(:one).id,
      movie_id: movies(:one).id,
    }
  }

  describe "check_out" do
    it "should create a new rental check_out given valid data" do
      current_checkouts = customers(:one).movies_checked_out_count

      expect {
        post new_check_out_path, params: rental_data
      }.must_change "Rental.count", 1

      customers(:one).reload
      expect(customers(:one).movies_checked_out_count).must_equal 1

      movies(:one).reload
      inventory = movies(:one).inventory
      expect(movies(:one).available_inventory).must_equal inventory - 1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"
      expect(body).must_include "check_out"
      expect(body).must_include "due_date"

      rental = Rental.find(body["id"].to_i)

      expect(rental.customer_id).must_equal rental_data[:customer_id]
      expect(rental.movie_id).must_equal rental_data[:movie_id]

      must_respond_with :success
    end

    it "returns an error for invalid rental data" do
      expect {
        post new_check_out_path
      }.must_change "Rental.count", 0

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "customer"
      must_respond_with :bad_request
    end
  end

  describe "check_in" do
    it "should assign the check in date given valid data" do
      current_checkouts = customers(:one).movies_checked_out_count
      post new_check_out_path, params: rental_data
      post check_in_path, params: rental_data

      customers(:one).reload
      expect(customers(:one).movies_checked_out_count).must_equal 0

      movies(:one).reload
      inventory = movies(:one).inventory
      expect(movies(:one).available_inventory).must_equal inventory

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"
      expect(body).must_include "check_out"
      expect(body).must_include "check_in"
      expect(body).must_include "due_date"

      rental = Rental.find(body["id"].to_i)

      expect(rental.check_in).must_equal Date.today

      must_respond_with :success
    end

    it "returns an error for invalid rental data" do
      post check_in_path

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "customer"
      must_respond_with :bad_request
    end
  end
end
