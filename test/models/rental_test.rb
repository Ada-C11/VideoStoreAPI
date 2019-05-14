require "test_helper"

describe Rental do
  let(:rental) { rentals(:two) }

  it "must be valid" do
    value(rental).must_be :valid?
  end

  describe "relations" do
    it "has a movie" do
      rental.must_respond_to :movie
      rental.movie.must_be_kind_of Movie
    end

    it "has a customer" do
      rental.must_respond_to :customer
      rental.customer.must_be_kind_of Customer
    end
  end

  describe "validations" do
    it "requires a checkout date" do
      rental.checkout_date = nil

      valid_rental = rental.valid?

      expect(valid_rental).must_equal false
      expect(rental.errors.messages).must_include :checkout_date
      expect(rental.errors.messages[:checkout_date]).must_equal ["can't be blank"]
    end
  end
end
