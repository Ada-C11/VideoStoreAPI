require "test_helper"
require "pry"

describe Rental do
  describe "validations" do
    it "must be a valid rental" do
      rental = Rental.new(customer_id: customers(:one).id, movie_id: movies(:two).id)
      rental.save
      rental.valid?.must_equal true
    end
  end

  describe "relations" do
    it "belongs_to movie" do
      rental = rentals(:one)
      rental.movie.must_equal movies(:GreenMile)
    end

    it "belongs_to customer" do
      rental = rentals(:one)
      rental.customer.must_equal customers(:one)
    end
  end
end
