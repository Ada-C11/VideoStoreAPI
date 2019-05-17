require "test_helper"

describe Rental do
  let(:rental) { rentals(:rental_one) }

  it "must be valid" do
    expect(rental.valid?).must_equal true
  end

  describe "relationships" do
    it "is only valid if the rental has a customer" do
      rental.customer = nil
      expect(rental.valid?).must_equal false
    end

    it "is only valid if the rental has a movie" do
      rental.movie = nil
      expect(rental.valid?).must_equal false
    end
  end
end
