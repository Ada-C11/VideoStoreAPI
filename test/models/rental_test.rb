require "test_helper"

describe Rental do
  let(:rental) { rentals(:rental_1) }

  it "must be valid" do
    expect(rental.valid?).must_equal true
  end

  describe "relationships" do
    it "will have one customer and only one" do 
    end

    it "will have one movie and only one" do 
    end
  end
end
