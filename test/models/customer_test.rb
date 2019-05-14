require "test_helper"

describe Customer do
  describe "relations" do
    it "has rentals" do
      customer = customers(:customer_one)
      customer.must_respond_to :rentals
      customer.rentals.each do |rental|
      rental.must_be_kind_of Rental
      end
    end
  end
end
