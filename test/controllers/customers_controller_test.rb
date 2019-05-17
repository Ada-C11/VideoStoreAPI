require "test_helper"

describe CustomersController do
  describe "index" do
    it "returns a list of customers" do
      get customers_path
      must_respond_with :success
    end

    it "returns all the customers" do
      get customers_path
      body = JSON.parse(response.body)
      expect(body.length).must_equal Customer.count
    end

    it "returns json" do
      get customers_path
      expect(response.header["Content-Type"]).must_include "json"
    end

    it "returns customers with exactly the required fields" do
      keys = %w( id movies_checked_out_count name phone postal_code registered_at )
      get customers_path
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal keys
      end
    end
  end
end
