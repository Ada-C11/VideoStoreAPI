require "test_helper"

describe Rental do
  let(:rental) { rentals(:one) }

  describe "validations" do
    it "must be valid" do
      value(rental).must_be :valid?
    end

    it "has required fields" do
      fields = [:movie_id, :customer_id, :checkout, :due_date, :status]

      fields.each do |field|
        expect(rental).must_respond_to field
      end
    end

    it "requires movie and customer ids" do
      required_fields = [:customer_id, :movie_id]

      required_fields.each do |field|
        rental[field] = nil
        expect(rental.valid?).must_equal false

        rental.reload
      end
    end

    it "must have a check_out date" do
      rental.checkout = nil
      valid = rental.save

      expect(valid).must_equal false
      expect(rental.errors.messages).must_include :checkout
    end

    it "must have a due date" do
      rental.due_date = nil
      valid = rental.save

      expect(valid).must_equal false
      expect(rental.errors.messages).must_include :due_date
    end

    it "must have a status" do
      rental.status = nil
      valid = rental.save

      expect(valid).must_equal false
      expect(rental.errors.messages).must_include :status
    end
  end

  describe "relations" do
    it "relates to a customer" do
      rental.must_respond_to :customer
      rental.customer.must_be_kind_of Customer
      expect(rental.customer.id).must_equal rental.customer_id
    end

    it "relates to a movie" do
      rental.must_respond_to :movie
      rental.movie.must_be_kind_of Movie
      expect(rental.movie.id).must_equal rental.movie_id
    end
  end

  describe "available?" do
    it "shows movie available if copy checked out but available inventory > 0" do
      movie = movies(:two)
      availability = rental.available?(movie.id)
      expect(availability).must_equal true
    end

    it "shows movie unavailable if all copies checked out" do
      movie = movies(:four)
      availability = rental.available?(movie.id)
      expect(availability).must_equal false
    end
  end
end
