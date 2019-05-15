require "test_helper"

describe Rental do
  let(:rental) { rentals(:one) }
  let(:customer) { customers(:sophie) }
  let(:movie) { movies(:one) }

  it "can be created" do
    value(rental.valid?).must_equal true
  end

  describe "relationships" do
    it "belongs to the customer" do
      rental.customer = customer

      expect(rental.customer_id).must_equal customer.id
    end

    it "can set the customer through the customer_id" do
      rental.customer_id = customer.id
      expect(rental.customer).must_equal customer
    end

    it "belongs to the movie" do
      rental.movie = movie
      expect(rental.movie_id).must_equal movie.id
    end

    it "can set the movie through through movie_id" do
      rental.movie_id = movie.id
      expect(rental.movie).must_equal movie
    end
  end
end
