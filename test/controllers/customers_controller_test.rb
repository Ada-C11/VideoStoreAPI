require "test_helper"

describe CustomersController do
  describe "index" do
    it "should get index" do
      get customers_path
      value(response).must_be :successful?
    end

    it "returns json" do
      get customers_path
      expect(response.header["Content-Type"]).must_include "json"
    end

    it "returns all of the customers" do
      get customers_path

      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "returns customers with exactly the required fields" do
      keys = %w(id movies_checked_out_count name phone postal_code registered_at)
      get customers_path
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal keys
      end
    end

    it "should get the correct path with query parameters" do
      assert_recognizes({ controller: "customers", action: "index", sort: "name" }, "/customers", sort: "name")
    end

    it "gets the correct path with n query" do
      assert_recognizes({ controller: "customers", action: "index", n: "10" }, "/customers", n: "10")
    end

    it "gets the correct path with p query" do
      assert_recognizes({ controller: "customers", action: "index", p: "10" }, "/customers", p: "10")
    end
  end

  describe "show" do
    it "should get show" do
      get customer_path(Customer.first)
      value(response).must_be :successful?
    end

    it "returns an error when customer ID is invalid" do
      get customer_path(Customer.last.id + 1)
      must_respond_with :not_found
      body = JSON.parse(response.body)
      expect(body["errors"]).must_be_kind_of Hash
    end

    it "still returns JSON if ID is invalid" do
      get customer_path(-1)
      expect(response.header["Content-Type"]).must_include "json"
    end
  end
end
