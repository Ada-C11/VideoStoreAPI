require "test_helper"

describe Customer do
  let(:customer) { Customer.new }

  it "must be valid" do
    value(customer).must_be :valid?
  end

  it "has rentals" do
    expect(Customer.first.rentals.count).must_equal 1
  end
end
