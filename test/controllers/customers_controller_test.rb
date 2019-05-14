require "test_helper"

describe CustomersController do
  describe "index" do
    it "should get index" do
      get customers_path
      value(response).must_be :successful?
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
      expect(body["errors"]).must_be_kind_of Array
    end
  end
end
