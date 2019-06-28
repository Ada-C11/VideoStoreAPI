require "test_helper"

describe Customer do
  describe "validations" do
    let(:customer) { customers(:one) }

    it "must be valid" do
      value(customer).must_be :valid?
    end

    it "must have a name" do
      customer.name = nil
      customer.valid?.must_equal false
    end

    it "must have a address" do
      customer.address = nil
      customer.valid?.must_equal false
    end

    it "must have a city" do
      customer.city = nil
      customer.valid?.must_equal false
    end

    it "must have a state" do
      customer.state = nil
      customer.valid?.must_equal false
    end

    it "must have a postal_code" do
      customer.postal_code = nil
      customer.valid?.must_equal false
    end

    it "must have a phone" do
      customer.phone = nil
      customer.valid?.must_equal false
    end

    it "must have a registered date" do
      customer.registered_at = nil
      customer.valid?.must_equal false
    end

    describe "relations" do
      it "can have many rentals" do
        customer = customers(:one)
        customer.must_respond_to :rentals
        customer.rentals.each do |rental|
          rental.must_be_kind_of Rental
        end
      end
    end
  end
end
