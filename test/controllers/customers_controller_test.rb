require "test_helper"

describe CustomersController do
  describe "index" do
    it "is a real working route" do
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
      keys = %w(id movies_checked_out_count name phone postal_code registered_at)
      get customers_path
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal keys
      end
    end

    it "sorts by name when given sort name query params" do
      get "/customers?sort=name"

      body = JSON.parse(response.body)
      body.first["name"].must_equal "Matt Saracen"
    end

    it "sorts by id when given sort id query params" do
      Customer.destroy_all
      customer1 = Customer.create(name: "Test 1")
      customer1.id = 1
      customer1.save
      customer2 = Customer.create(name: "Test 2")
      customer2.id = 2
      customer2.save

      get "/customers?sort=id"

      body = JSON.parse(response.body)
      expect(body.first["name"]).must_equal "Test 1"
      expect(body.first["id"]).must_equal 1
    end

    it "paginates the customer index" do
      Customer.destroy_all
      customer1 = Customer.create(name: "Test 1")
      customer1.id = 1
      customer1.save
      customer2 = Customer.create(name: "Test 2")
      customer2.id = 2
      customer2.save

      get "/customers?n=1&p=2"

      body = JSON.parse(response.body)
      expect(body.first["name"]).must_equal "Test 2"
      expect(body.first["id"]).must_equal 2
    end

    it "paginates and sorts by name" do

      get "/customers?sort=name&n=1&p=2"

      body = JSON.parse(response.body)
      expect(body.first["name"]).must_equal "Tim Riggins"
    end
  end
end
