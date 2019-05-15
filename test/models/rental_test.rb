require "test_helper"

describe Rental do
  before do
    @movie = Movie.first
    @customer = Customer.first
    @rental = Rental.create(movie_id: @movie.id, customer_id: @customer.id)
  end

  describe "validations" do
    it "requires a customer_id" do
      @rental.customer_id = nil
      valid_rental = @rental.valid?

      expect(valid_rental).must_equal false
      expect(@rental.errors.messages).must_include :customer_id
    end

    it "requires a movie_id" do
      @rental.movie_id = nil
      valid_rental = @rental.valid?

      expect(valid_rental).must_equal false
      expect(@rental.errors.messages).must_include :movie_id
    end
  end

  describe "relationships" do
    it "belongs to a customer" do
      expect(@rental.customer).must_equal @customer
      expect(@customer.rentals).must_include @rental
    end

    it "belongs to a movie" do
      expect(@rental.movie).must_equal @movie
      expect(@movie.rentals).must_include @rental
    end
  end

  describe "custom methods" do
    describe "prepare_for_checkout" do
      it "sets the required fields and returns true" do
        expect(@rental.prepare_for_checkout).must_equal true

        expect(@rental.checkout_date).must_equal Date.today
        expect(@rental.due_date).must_equal (Date.today + 7.days)
        expect(@rental.currently_checked_out).must_equal true
      end

      it "returns false if unable to save" do
        bad_rental = Rental.new

        expect(bad_rental.prepare_for_checkout).must_equal false
      end
    end
  end
end
