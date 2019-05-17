require "test_helper"

describe Customer do
  let(:customer) { customers(:one) }

  it "can be created" do
    expect(customer.valid?).must_equal true
  end

  it "requires name" do
    customer[:name] = nil
    expect(customer.valid?).must_equal false
    customer.reload
  end

  describe "relations" do
    it "has many movies" do
      customer.must_respond_to :movies
      customer.movies.each do |movie|
        movie.must_be_kind_of Movie
      end
    end
    it "can have no movie" do
      customer.rentals.destroy_all
      customer.must_respond_to :movies
      expect(customer.movies).must_equal []
    end
    it "can have many rentals" do
      customer.must_respond_to :rentals
      customer.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end
    it "can have no rental" do
      customer.rentals.destroy_all
      customer.must_respond_to :rentals
      expect(customer.rentals).must_equal []
    end
  end
end
