require "test_helper"

describe CustomersController do
  describe "index" do
    it "can get customers" do
      get customers_path
      must_respond_with :success
    end

    it "returns json" do
      get customers_path
      expect(response.header["Content-Type"]).must_include "json"
    end

    it "returns an Array" do
      get customers_path

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the customers" do
      get customers_path

      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "returns customers with exactly the required fields" do
      keys = %w(id name postal_code phone movies_checked_out_count registered_at)
      get customers_path
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.must_equal keys
      end
    end
  end

  describe "show" do
    it "can get a customer with valid info" do
      get customer_path(customers(:two).id)
      must_respond_with :success
      expect(response.header["Content-Type"]).must_include "json"
    end
    it "raises an error and return not found if given invalid params" do
      get customer_path(100)
      must_respond_with :not_found
      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "customer"
    end
  end

  describe "create" do
    let(:customer_data) {
      {
        name: "Chris Tucker",
        address: "555 Scammer Drive",
        city: "Seattle",
        state: "WA",
        postal_code: "11111",
        phone: "123-867-5309",
        movies_checked_out_count: 2,
        registered_at: DateTime.now,
      }
    }

    it "creates a new customer given valid data" do
      expect {
        post customers_path, params: {customer: customer_data}
      }.must_change "Customer.count", 1

      body = JSON.parse(response.body)
      expect(response.header["Content-Type"]).must_include "json"
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      customer = Customer.find(body["id"].to_i)

      expect(customer.name).must_equal customer_data[:name]
      must_respond_with :success
    end

    it "returns an error for invalid customer data" do
      customer_data["name"] = nil

      expect {
        post customers_path, params: {customer: customer_data}
      }.wont_change "Customer.count"

      body = JSON.parse(response.body)
      expect(response.header["Content-Type"]).must_include "json"
      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "name"
      must_respond_with :bad_request
    end
  end
end
