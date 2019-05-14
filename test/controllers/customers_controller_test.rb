require "test_helper"

describe CustomersController do
  describe "index" do
    it "returns a list of customers" do
      get customers_path
      must_respond_with :success
    end
  end
end
