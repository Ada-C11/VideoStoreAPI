require "test_helper"

describe CustomersController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

  # it "sends back ok and list of customers" do
  #   get customers_path
  #   must_respond_with :ok
  # end

  describe "index" do
    # These tests are a little verbose - yours do not need to be
    # this explicit.
    it "is a real working route" do
      get customers_path
      must_respond_with :success
    end

    # it "returns json" do
    #   get pets_path
    #   expect(response.header["Content-Type"]).must_include "json"
    # end

    # it "returns an Array" do
    #   get pets_path

    #   body = JSON.parse(response.body)
    #   body.must_be_kind_of Array
    # end

    # it "returns all of the pets" do
    #   get pets_path

    #   body = JSON.parse(response.body)
    #   body.length.must_equal Pet.count
    # end

    # it "returns pets with exactly the required fields" do
    #   keys = %w(age human id name)
    #   get pets_path
    #   body = JSON.parse(response.body)
    #   body.each do |pet|
    #     pet.keys.sort.must_equal keys
    #   end
    # end
  end
end
