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

  describe "check_in" do
    it "can check in with today's date" do
      rental = Rental.new(customer: customer,
                          movie: movie,
                          checkout_date: Date.today - 14,
                          due_date: Date.today - 7,
                          checkin_date: nil)
      rental.check_in
      expect(rental.checkin_date).must_equal Date.today
    end
  end
end
