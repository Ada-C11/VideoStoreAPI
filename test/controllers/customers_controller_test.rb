require "test_helper"

describe CustomersController do
  describe "index" do
    it "is a real working route" do
      # Arrange - Act
      get customers_path

      # Assert
      must_respond_with :success
    end

    it "returns json" do
      # Arrange - Act
      get customers_path

      # Assert
      expect(response.header['Content-Type']).must_include 'json'
    end

    it "returns an Array" do
      # Arrange - Act
      get customers_path

      # Assert
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all the customers" do
      # Arrange - Act
      get customers_path

      # Assert
      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "returns customers with exactly the required fields" do 
      # Arrange
      keys = %w(id name registered_at postal_code phone)

      # Act
      get customers_path
      body = JSON.parse(response.body)

      # Assert
      body.each do |customer|
        customer.keys.must_equal keys
      end
    end
  end
end
