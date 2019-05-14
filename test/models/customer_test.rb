require "test_helper"
require 'pry'

describe Customer do
  let(:customer) { customers(:donald) }

  it "can be created" do
    expect(customer.valid?).must_equal true
  end

  it "requires name and phone number" do
    required_fields = [:name, :phone]
    required_fields.each do |field|
       customer[field] = nil
       expect(customer.valid?).must_equal false
       customer.reload
    end
  end
end
