require "test_helper"

describe Rental do
  let(:rental) { rentals(:one) }

  it "requires movie and customer ids" do
    required_fields = [:customer_id, :movie_id]

    required_fields.each do |field|
      rental[field] = nil
      expect(rental.valid?).must_equal false

      rental.reload
    end
  end

  describe "relations" do
    it "relates to a customer" do
      r = rentals(:one)
      r.must_respond_to :customer
      r.customer.must_be_kind_of Customer
    end

    it "relates to a movie" do
      r = rentals(:one)
      r.must_respond_to :movie
      r.movie.must_be_kind_of Movie
    end
  end
end

