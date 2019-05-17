require "test_helper"
require "pry"

describe CustomersController do
  describe "get customer endpoint (index)" do
    it "is a real working route and returns JSON" do
      get customers_path
    
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :success
    end
    it "is a real working route and returns JSON if there are no customer" do
      Customer.destroy_all
      get customers_path
    
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :success
    end
    it "returns an Array" do
      get customers_path
    
      body = JSON.parse(response.body)
    
      expect(body).must_be_kind_of Array
    end
    it "returns all of the customers" do
      get customers_path
    
      body = JSON.parse(response.body)
    
      expect(body.length).must_equal Customer.count
    end
    it "returns customers with exactly the required fields" do
      keys = %w(id movies_checked_out_count name phone postal_code registered_at )
    
      get customers_path
    
      body = JSON.parse(response.body)
    
      body.each do |customer|
        expect(customer.keys.sort).must_equal keys
        expect(customer.keys.length).must_equal keys.length
      end
    end

  end
  # describe "show" do
  #   it "can get a customer" do
  #     get customer_path(customers(:one).id)
  #     must_respond_with :success
  #   end
    
  #   it "responds with a 404 message if no pet is found" do
  #     id = -1
  #     get customer_path(id)
  #     must_respond_with :not_found
  #   end
  # end





end
