require "test_helper"

describe RentalsController do
  let(:rental_data){
    {
      movie_id: movies(:aladdin).id,
      customer_id: customers(:steph).id,
    }
  }

  describe "checkout" do
    it "creates a new rental with valid information" do
      expect{
        post check_out_path, params: rental_data
      }.must_change 'Rental.count', +1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      rental = Rental.find(body["id"].to_i)

      expect(rental.movie.id).must_equal rental_data[:movie_id]
      must_respond_with :success
    end
  

    it "does not create a rental with invalid information for movie" do
      rental_data[:movie_id] = -1 
      
      expect {
        post check_out_path, params: rental_data
      }.wont_change "Rental.count"
    
      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      must_respond_with :bad_request
    end

    it "does not create a rental with invalid information for customer" do
      rental_data[:customer_id] = -1

      expect {
        post check_out_path, params: rental_data
      }.wont_change "Rental.count"
    
      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      must_respond_with :bad_request

    end
  end

    describe "checkin" do
      it "can check in a rental that was checked out" do
        post check_out_path, params: rental_data
        post check_in_path, params: rental_data

        body = JSON.parse(response.body)
        expect(body).must_be_kind_of Hash
        expect(body).must_include "id"
  
        rental = Rental.find(body["id"].to_i)

        expect(rental.return_date).wont_equal nil
        must_respond_with :success
      end
    end
end
