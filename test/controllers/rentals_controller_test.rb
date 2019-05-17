require "test_helper"

describe RentalsController do

  describe 'checkout' do
    before do 
      @rental_data = {
        customer_id: Customer.first.id, 
        movie_id: Movie.last.id 
      }
    end 

    it "creates a new rental given valid data" do
      expect {
        post checkout_path, params: @rental_data
      }.must_change "Rental.count", +1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash

      rental = Rental.last

      expect(rental.customer_id).must_equal @rental_data[:customer_id]
      expect(rental.movie_id).must_equal @rental_data[:movie_id]

      must_respond_with :success
    end

    it 'does returns error has if movie is unavailiable' do
      movie = Movie.find_by(id: @rental_data[:movie_id])
      movie.inventory = 0
      movie.save 

      expect {
        post checkout_path, params: @rental_data
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)

      expect(response.header["Content-Type"]).must_include "json"
      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      
      must_respond_with :bad_request
    end 

    it "returns a JSON with error for invalid rental data" do
      @rental_data["customer_id"] = -1

      expect {
        post checkout_path, params: @rental_data
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)

      expect(response.header["Content-Type"]).must_include "json"
      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      
      must_respond_with :bad_request
    end
  end 

  describe 'checkin' do
    let(:rental) {rentals(:one)}
    

    it "checks-in a rental given valid data" do
      rental_hash = {
          customer_id: rental.customer.id, 
          movie_id: rental.movie.id,
      }
      
      post checkin_path, params: rental_hash

      rental.reload

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash

      rental = Rental.find_by(customer_id: rental_hash[:customer_id], movie_id: rental_hash[:movie_id])

      expect(rental.customer_id).must_equal rental_hash[:customer_id]
      expect(rental.movie_id).must_equal rental_hash[:movie_id]

      must_respond_with :success
    end

    it "returns a JSON with error for invalid rental data" do
      rental_hash = {
        customer_id: rental.customer.id, 
        movie_id: -1,
    }

      expect {
        post checkout_path, params: rental_hash
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)

      expect(response.header["Content-Type"]).must_include "json"
      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      
      must_respond_with :bad_request
    end
  end 
end
