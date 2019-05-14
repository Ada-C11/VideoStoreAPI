require "test_helper"

describe Customer do
  let(:customer) { customers(:one) }

  it "requires a name" do
    required_fields = [:name]

    required_fields.each do |field|
       customer[:name] = nil

       expect(customer.valid?).must_equal false

       customer.reload
    end
  end
end
