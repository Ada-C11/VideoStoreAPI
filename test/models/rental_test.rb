require "test_helper"

describe Rental do
  let(:rental) {
  Rental.new(movie_id: Movie.first.id, customer_id: Customer.first.id)
  }

  describe "validations" do
    it "requires a customer_id" do
      rental = Rental.new(movie_id: Movie.first.id, customer_id: nil)

      invalid_rental = rental.valid?

      expect(invalid_rental).must_equal false
      rental.errors.messages.must_include :customer_id
    end

    it "requires a movie_id" do
      rental = Rental.new(movie_id: nil, customer_id: Customer.first.id)

      invalid_rental = rental.valid?
      expect(invalid_rental).must_equal false
      rental.errors.messages.must_include :movie_id
      
    end
  end

  describe "relations" do
    it "has a relationship with customer" do
      expect(rental).must_respond_to :customer
    end

    it "has a relationship with movie" do
      expect(rental).must_respond_to :movie
    end
  end
  
  describe "custom menthods" do
    describe "set checkout date" do
      it "will set the checkout dates" do
        expect(rental.set_checkout_date).must_equal true
        expect(rental.checkout_date).must_equal Date.today
        expect(rental.due_date).must_equal Date.today + 7.days
        expect(rental.currently_checked_out).must_equal true
      end

      it "will set the checkin date" do
        expect(rental.set_checkin_date).must_equal true
        expect(rental.checkin_date).must_equal Date.today
        expect(rental.currently_checked_out).must_equal false
      end
    end
  end
end