require "test_helper"

describe CustomersController do
  it "should get index" do
    get customers_path
    value(response).must_be :successful?
  end

  it "should get show" do
    get customer_path(Customer.first)
    value(response).must_be :successful?
  end
end
