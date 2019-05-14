require "test_helper"

describe Customer do
  let(:customer) { Customer.new }
  let(:valid_customer) { customers(:bob) }

  it "must be valid" do
    expect(valid_customer).must_be :valid?
  end

  it "requires a name" do
    expect(customer.valid?).must_equal false
  end
end
