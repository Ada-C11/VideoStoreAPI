require "test_helper"

describe Customer do
  let(:customer) { customers(:sophie) }
  let(:movie) { movies(:one) }
  describe "validations" do
    it "must be valid" do
      expect(customer.valid?).must_equal true
    end
  end

  describe "relationships" do
    it "returns all the rentals" do
      customer.rentals
      expect(customer.rentals.count).must_equal 2
    end

    it "can have 1 or more rentals" do
      first_rental = rentals(:one)
      first_rental.customer_id = customer.id
      first_rental.movie_id = movies(:one).id
      first_rental.save

      second_rental = rentals(:two)
      second_rental.customer_id = customer.id
      second_rental.movie_id = movies(:two).id
      second_rental.save
      expect(customer.rentals).must_include first_rental
      expect(customer.rentals).must_include second_rental
    end
  end

  describe "movies_checked_out_count" do
    it "can get the number of movies checked out" do
      first_rental = rentals(:one)
      first_rental.customer_id = customer.id
      first_rental.movie_id = movies(:one).id
      first_rental.save
      second_rental = rentals(:two)
      second_rental.customer_id = customer.id
      second_rental.movie_id = movies(:two).id
      second_rental.save
      expect(customer.movies_checked_out_count).must_equal 2
    end

    it "returns 0 if there's no movie checked out" do
      rentals.each do |rental|
        rental.destroy
      end
      expect(customer.movies_checked_out_count).must_equal 0
    end
  end
end
