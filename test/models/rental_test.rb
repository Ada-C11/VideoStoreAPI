require "test_helper"

describe Rental do
  describe "validations" do
    let(:rental_info) {
      {
        movie_id: movies.first.id,
        customer_id: customers.first.id,
      }
    }
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
  end
end
