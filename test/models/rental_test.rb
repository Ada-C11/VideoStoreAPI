require "test_helper"

describe Rental do
  let(:rental_info) {
    {
      movie_id: movies.first.id,
      customer_id: customers.first.id,
    }
  }
  describe "validations" do
    it "can create a rental with good data" do
      rental = Rental.new(rental_info)
      result = rental.valid?

      expect(result).must_equal true
    end

    it "wont be valid without a movie_id" do
      rental_info[:movie_id] = nil
      rental = Rental.new(rental_info)
      result = rental.valid?

      expect(result).must_equal false
    end
    it "wont be valid without a customer_id" do
      rental_info[:customer_id] = nil
      rental = Rental.new(rental_info)
      result = rental.valid?

      expect(result).must_equal false
    end
  end

  describe "relationships" do
    before do
      @rental = Rental.new(rental_info)
    end
    it "can access its movie through .movie" do
      movie = @rental.movie
      expect(movie).must_be_instance_of Movie
      expect(movie.id).must_equal @rental.movie_id
    end
    it "can access its customer through .customer" do
      customer = @rental.customer
      expect(customer).must_be_instance_of Customer
      expect(customer.id).must_equal @rental.customer_id
    end
  end
end
