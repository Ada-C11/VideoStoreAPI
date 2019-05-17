require "test_helper"

describe CustomersController do
  describe "index" do
    it "returns JSON and the route is working" do
      get customers_path, as: :json

      expect(response.header["Content-Type"]).must_include "json"
      must_respond_with :success
    end

    it "returns an array" do
      get customers_path, as: :json

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Array
    end

    it "returns all of the customers" do
      get customers_path, as: :json

      body = JSON.parse(response.body)

      expect(body.length).must_equal Customer.count
    end
  end
end
