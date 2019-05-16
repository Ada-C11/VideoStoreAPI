require "test_helper"
require "pry"

describe CustomersController do
  describe "index" do
    it "customers_path is a working route" do
      get customers_path
      must_respond_with :success
    end

    it "returns json" do
      get customers_path
      expect(response.header["Content-Type"]).must_include "json"
    end

    it "returns an array" do
      get customers_path
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all customers" do
      get customers_path
      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "returns customer with the fields required to be included in the json" do
      keys = ["id", "name", "registered_at", "address", "city", "state", "postal_code", "phone"]
      get customers_path
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.must_equal keys
      end
    end

    it "return 'no customer' message if there are no customers" do
      Customer.destroy_all
      get customers_path
      must_respond_with :success
      expect(JSON.parse(response.body)["message"]).must_equal "There are currently no customers."
    end
  end
end
