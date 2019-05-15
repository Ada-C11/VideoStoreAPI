require "test_helper"

describe Customer do
  let(:customer) { customers.first }
  describe "checkout_movies_count" do
    it "increases customer movies checked out count by one" do
      start_count = customer.movies_checked_out_count
      customer.checkout_movies_count

      expect(start_count + 1).must_equal customer.movies_checked_out_count
    end
  end

  describe "checkin_movies_count" do
    it "reduces the movie count by one if it is more than 0" do
      customer.movies_checked_out_count = 1
      customer.save
      Customer.checkin_movies_count(customer)

      expect(customer.movies_checked_out_count).must_equal 0
    end

    it "returns false if the movie count is less than 1" do
      customer.movies_checked_out_count = 0
      customer.save
      expect(Customer.checkin_movies_count(customer)).must_equal false
    end
  end
end
