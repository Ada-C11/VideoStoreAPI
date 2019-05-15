require "test_helper"

describe RentalsController do
  describe 'checkout' do
    let(:rental_data) {
      {
        customer_id: customers(:nara).id,
        movie_id: movies(:one).id
      }
    }
    it "can checkout given valid data" do
      expect {
        post check_out_path, params: rental_data
      }.must_change "Rental.count", 1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      rental = Rental.find(body["id"].to_i)

      expect(rental.movie.id).must_equal rental_data[:movie_id]
      must_respond_with :success
    end

    it "retuns an error for rental data with invalid customer" do
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

    it "retuns an error for rental data with invalid movie" do
      rental_data["movie_id"] = -1
      
      expect {
        post check_out_path, params: rental_data
      }.wont_change "Rental.count"
      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      must_respond_with :not_found
    end
  end

  describe "checkin" do
    let(:rental_data) {
      {
        customer_id: customers(:nara).id,
        movie_id: movies(:one).id
      }
    }
    it "cannot checkin when there is no rental " do
      
      post check_in_path, params: rental_data
      
      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      must_respond_with :bad_request
    end

    it "can checkin checked out rental" do
      post check_out_path, params: rental_data

      post check_in_path, params: rental_data
      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      rental = Rental.find(body["id"].to_i)

      expect(rental.checkin_date).wont_equal nil
      must_respond_with :success
    end 

    it "cannot checkin already checked in rental" do
      post check_out_path, params: rental_data
      post check_in_path, params: rental_data
      post check_in_path, params: rental_data
      
      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      must_respond_with :bad_request
    end 
  end
end
