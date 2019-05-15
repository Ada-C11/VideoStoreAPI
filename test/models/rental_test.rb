require "test_helper"

describe Rental do
  let(:rental) { rentals(:one) }
  
  it "can be created" do
    value(rental.valid?).must_equal true
  end
end
