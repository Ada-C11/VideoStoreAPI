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

  describe "validations" do
    it "is valid if it has a name" do
      customer = Customer.new(name: "Test")
      customer.valid?.must_equal true
    end

    it "is not valid without a name" do
      customer = Customer.new
      customer.valid?.must_equal false
      customer.errors.messages.must_include :name
    end
  end
end
