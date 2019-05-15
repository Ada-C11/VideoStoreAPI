require "test_helper"

describe RentalsController do
  
  describe "Checkout" do
  
    let(:movie) {movies(:two)}
    let(:customer) {customers(:two)}
    let(:rental_data) {
       {
          movie_id: movie.id,
          customer_id: customer.id,
        }
      }
      
    it "creates a Rental and sets a due date" do
      expect {
        post checkout_path, params: { rental: rental_data }
      }.must_change "Rental.count", 1
    
      must_respond_with :success
    end
    
    it "creates a due date" do
      post checkout_path, params: { rental: rental_data }
    
      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"
      
      rental = Rental.find(body["id"].to_i)
      
      expect(rental.due_date).wont_be_nil
      expect(rental.due_date).must_be_kind_of DateTime
     
      expect(rental.movie.id).must_equal rental_data[:movie_id] 
    end
    
    it "renders as JSON" do
      post checkout_path, params: { rental: rental_data }
      
      expect(response.header["Content-Type"]).must_include "json"
    end
    
    it "returns a customer ID and movie ID" do
      post checkout_path, params: { rental: rental_data }
      
      body = JSON.parse(response.body)
      
      expect(body).must_include "customer_id"
      expect(body).must_include "movie_id"
    end
  end
end
