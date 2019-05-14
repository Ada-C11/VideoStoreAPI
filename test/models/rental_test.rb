require "test_helper"

describe Rental do
  let (:rental) { rentals(:one) }

  it "must be valid given good data" do
    expect(rental.valid?).must_equal true
  end

  it "requires due_date" do
    required_fields = [:due_date]

    rental.due_date = nil
    expect(rental.valid?).must_equal false
    rental.reload
  end
end
