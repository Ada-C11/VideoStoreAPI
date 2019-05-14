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

    it "must be type datetime for registered at" do 
      customer.registered_at = "this is not a date"
      customer.valid?.must_equal false
    end

    it "must have a postal code" do 
      customer.postal_code = nil 
      customer.valid?.must_equal false 
    end
  end

  describe "relationships" do 
    it "has many rentals" do 
      customer = Customer.first 
      customer.rentals.each do |rental|
        rental.must_be_instance_of Rental 
      end
    end
  end
end
