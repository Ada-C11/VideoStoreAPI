require "test_helper"

describe Rental do
  let(:rental) { rentals(:one) }

  it "must be valid" do
    value(rental).must_be :valid?
  end
end
