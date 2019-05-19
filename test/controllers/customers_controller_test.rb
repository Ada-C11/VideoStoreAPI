require "test_helper"

describe CustomersController do
  let(:customer) { customers(:chewy) }

  it "should get index" do
    get customers_path
    value(response).must_be :successful?
  end

  it "returns json" do
    get customers_path
    expect(response.header["Content-Type"]).must_include "json"
  end
  describe "show" do
    it "can get show" do
      get customer_path(customers(:chewy).id)
      value(response).must_be :successful?
    end

    it "redirects if customer not found" do
      get customer_path(-7)
      must_respond_with :not_found
    end
  end
end
