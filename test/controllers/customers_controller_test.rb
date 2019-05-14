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
  end
end
