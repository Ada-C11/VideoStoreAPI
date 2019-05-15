require "test_helper"

describe RentalsController do
  describe "checkout" do
    let(:rental_data) {
      {
        customer_id: customers(:customer_one).id,
        movie_id: movies(:movie_one).id,
      }
    }

    it "creates a new rental given valid data" do
      expect {
        post checkout_path, params: rental_data
      }.must_change "Rental.count", 1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      rental = Rental.find(body["id"].to_i)

      expect(rental.customer_id).must_equal rental_data[:customer_id]
      must_respond_with :success
    end

    it "returns an error for invalid rental data" do
      # arrange
      rental_data["customer_id"] = nil

      expect {
        post checkout_path, params: rental_data
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "customer_id"
      must_respond_with :bad_request
    end

    it "increases customers movies_checked_out_count by 1" do
      # rental_data2 = {
        rental = {
          customer_id: customers(:customer_two).id,
          movie_id: movies(:movie_one).id,
        }
     # }
    
      customer = customers(:customer_one)
      # customer_checkout_count = customer.movies_checked_out_count
  
        post checkout_path, params: rental
      
        expect(customer.movies_checked_out_count).must_equal 1
      
    end

    it "decreases movie available inventory count by 1" do

    end
  end

  describe "checkin" do
    let(:rental_data) {
      {
        customer_id: customers(:customer_one).id,
        movie_id: movies(:movie_one).id,
      }
    }
    it "destroys checkout when given valid data" do
      expect {
        post checkin_path, params: rental_data
      }.must_change "Rental.count", -1
    end

    it "it returns an error if rental is not found" do
      rental_data["customer_id"] = customers(:customer_two).id
      expect {
        post checkin_path, params: rental_data
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "Rental not found"
      must_respond_with :bad_request
    end
  end
end
