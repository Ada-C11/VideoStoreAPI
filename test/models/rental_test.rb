require "test_helper"

describe Rental do
  let(:rental) { rentals(:one) }


  describe "relationships" do
    it "has a customer" do
      expect(rental.customer).must_be_instance_of Customer
    end

    it "has a movie" do
      expect(rental.movie).must_be_instance_of Movie
    end 
  end
end
