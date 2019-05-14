require "test_helper"

describe Customer do
  describe "validations" do
    let(:customer) { customers(:hana) }

    describe "validations" do
      it "is valid when all fields are present" do
        result = customer.valid?

        expect(result).must_equal true
      end

      it "must have a name" do
        customer.name = nil
        customer.valid?.must_equal false

        expect(customer.errors.messages).must_include :name
        expect(customer.errors.messages[:name]).must_equal ["can't be blank"]
      end

      it "must be type datetime for registered at" do
        customer.registered_at = nil
        customer.valid?.must_equal false

        expect(customer.errors.messages).must_include :registered_at
        expect(customer.errors.messages[:registered_at]).must_equal ["can't be blank"]
      end

      it "must have a postal code" do
        customer.postal_code = nil
        customer.valid?.must_equal false

        expect(customer.errors.messages).must_include :postal_code
        expect(customer.errors.messages[:postal_code]).must_equal ["can't be blank"]
      end
    end
  end

  describe "relations" do
    it "has many rentals" do
      customer = Customer.first
      customer.must_respond_to :rentals
      customer.rentals.each do |rental|
        rental.must_be_instance_of Rental
      end
    end
  end
end
