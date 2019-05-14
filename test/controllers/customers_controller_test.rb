require "test_helper"

describe CustomersController do
  it "should get index" do
    get customers_path
    value(response).must_be :success?
  end

  it "returns customers with exactly the required fields" do
    keys = %w(address city id name phone postal_code registered_at state)
    get customers_path
    body = JSON.parse(response.body)
    body.each do |customer|
      customer.keys.sort.must_equal keys
    end
  end 

end
