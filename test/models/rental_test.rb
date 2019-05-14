require "test_helper"

describe Rental do
  let(:rental) { rentals(:rental_1) }

  it "must be valid" do
    expect(rental.valid?).must_equal true
  end

  describe "relationships" do
    it "will have one customer and only one" do
      expect(rental.movie).must_equal movies(:movie_1)
    end

    it "will have one movie and only one" do
      expect(rental.customer).must_equal customers(:customer_1)
    end
  end
end
