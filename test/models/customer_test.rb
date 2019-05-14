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
    it "can have 0 rentals" do
      customer.rentals
      expect(customer.rentals.count).must_equal 0
    end

    it "can have 1 or more rentals" do
      rental = Rental.create(customer_id: customer.id,
                             movie_id: movie.id,
                             checkout_date: Date.today,
                             due_date: Date.today + 7)

      customer.rentals << rental
      expect(customer.rentals).must_include rental
    end
  end
end
