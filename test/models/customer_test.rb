require "test_helper"

describe Customer do
  let (:customer) { customers(:one) }
  before do
    @customer = Customer.new(
      name: "test_name",
      phone: "132-456-7890",
      registered_at: DateTime.now,
    )
  end

  it "must be valid given good data" do
    expect(@customer).must_be :valid?
  end

  it "requires name, phone, registered_at" do
    required_fields = [:name, :phone, :registered_at]

    required_fields.each do |field|
      customer[field] = nil
      expect(customer.valid?).must_equal false
      customer.reload
    end
  end
end
