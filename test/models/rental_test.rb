require "test_helper"

describe Rental do
  let(:rental) { rentals(:one) }

  describe "validations" do
    it "must be valid" do
      value(rental).must_be :valid?
    end

    it "has required fields" do
      fields = [:movie_id, :customer_id, :check_out, :check_in, :status]

      fields.each do |field|
        expect(rental).must_respond_to field
      end
    end

    it "must have a check_out date" do
      rental.check_out = nil
      valid = rental.save

      expect(valid).must_equal false
      # expect(rental.errors.messages).must_include :check_out
    end

    it "must have a check_in date" do
      rental.check_in = nil
      valid = rental.save

      expect(valid).must_equal false
      # expect(rental.errors.messages).must_include :check_in
    end

    it "must have a status" do
      rental.status = nil
      valid = rental.save

      expect(valid).must_equal false
      # expect(rental.errors.messages).must_include :status
    end

    it "must have a customer_id foreign key" do
      rental.customer_id = nil
      valid = rental.save

      expect(valid).must_equal false
      # expect(rental.errors.messages).must_include :customer_id
    end

    it "must have a movie_id foreign key" do
      rental.movie_id = nil
      valid = rental.save

      expect(valid).must_equal false
      # expect(rental.errors.messages).must_include :movie_id
    end
  end

  describe "relations" do
    it "must have a Customer" do
      rental_one = rentals(:one)
      rental_one.must_respond_to :customer
      rental_one.customer.must_be_kind_of Customer
      rental_one.customer.name.must_equal "Stugene"
      rental_one.customer.must_equal customers(:one)
    end

    it "must have a movie" do
      rental_one = rentals(:one)
      rental_one.must_respond_to :movie
      rental_one.movie.must_be_kind_of Movie
      rental_one.movie.title.must_equal "Wild Hearts Can't Be Broken"
      rental_one.movie.must_equal movies(:wild)
    end
  end

  describe "custom method" do
    it "checks that movie is available when there are more in inventory than are checked out" do
      movie = movies(:will)
      answer = rental.movie_avail?(movie.id)
      expect(answer).must_equal true
    end

    it "checks that movie is not available when there are none in inventory" do
      movie = movies(:harvey)
      answer = rental.movie_avail?(movie.id)
      expect(answer).must_equal false
    end
  end
end
