require "test_helper"

describe CustomersController do
  let(:customer) { customers(:one) }
  describe "index" do
    it "should get index" do
      get customers_path

      expect(response.header["Content-Type"]).must_include "json"
      must_respond_with :success
    end

    it "returns an Array with all customers" do
      get customers_path

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Array
      expect(body.length).must_equal Customer.count
    end

    it "returns customers with exactly the required fields" do
      keys = %w(id movies_checked_out_count name phone postal_code registered_at)

      get customers_path

      body = JSON.parse(response.body)

      body.each do |customer|
        expect(customer.keys.sort).must_equal keys
        expect(customer.keys.length).must_equal keys.length
      end
    end
  end
end
