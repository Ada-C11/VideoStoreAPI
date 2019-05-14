require "test_helper"

describe Customer do
  before do
    @customer = Customer.new(
      name: "test_name",
      phone: "132-456-7890",
      registered_at: DateTime.now,
    )
    @invalid_customer = Customer.new(
      name: "",
      phone: "132-456-7890",
      registered_at: DateTime.now,
    )
  end

  it "must be valid given good data" do
    expect(@customer).must_be :valid?
  end
  it "will throw an error if given invalid data" do
    result = @invalid_customer.valid?
    expect(result).must_equal false
  end
end
