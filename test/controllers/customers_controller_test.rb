require "test_helper"

describe CustomersController do
  it "should get index" do
    get customers_path
    value(response).must_be :success?
  end

  it "returns customers with exactly the required fields" do
    keys = %w(address city id movies_checked_out_count name phone postal_code registered_at state)
    get customers_path
    body = JSON.parse(response.body)
    body.each do |customer|
      customer.keys.sort.must_equal keys
    end
  end 

  it "gets index even without any customers" do
    Rental.destroy_all
    Customer.destroy_all
    expect(Customer.count).must_equal 0
    get customers_path
    value(response).must_be :success?
  end

end
