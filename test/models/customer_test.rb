require "test_helper"

describe Customer do
  let(:customer) { customers(:jose) }

  it "must be valid" do
    value(customer).must_be :valid?
  end

  it "must have a valid customer" do
    valid_customer = customer.valid?
    expect(valid_customer).must_equal true
  end

  describe "validations" do
    it "requires a name" do
      customer.name = ""
      valid_customer = customer.valid?

      expect(valid_customer).must_equal false
      expect(customer.errors.messages).must_include :name
      expect(customer.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it "requires a registered location" do
      customer.registered_at = ""
      valid_customer = customer.valid?

      expect(valid_customer).must_equal false
      expect(customer.errors.messages).must_include :registered_at
      expect(customer.errors.messages[:registered_at]).must_equal ["can't be blank"]
    end

    it "requires a address" do
      customer.address = ""
      valid_customer = customer.valid?

      expect(valid_customer).must_equal false
      expect(customer.errors.messages).must_include :address
      expect(customer.errors.messages[:address]).must_equal ["can't be blank"]
    end

    it "requires a city" do
      customer.city = ""
      valid_customer = customer.valid?

      expect(valid_customer).must_equal false
      expect(customer.errors.messages).must_include :city
      expect(customer.errors.messages[:city]).must_equal ["can't be blank"]
    end

    it "requires a state" do
      customer.state = ""
      valid_customer = customer.valid?

      expect(valid_customer).must_equal false
      expect(customer.errors.messages).must_include :state
      expect(customer.errors.messages[:state]).must_equal ["can't be blank"]
    end

    it "requires a postal code" do
      customer.postal_code = ""
      valid_customer = customer.valid?

      expect(valid_customer).must_equal false
      expect(customer.errors.messages).must_include :postal_code
      expect(customer.errors.messages[:postal_code]).must_equal ["can't be blank"]
    end

    it "requires a phone" do
      customer.phone = ""
      valid_customer = customer.valid?

      expect(valid_customer).must_equal false
      expect(customer.errors.messages).must_include :phone
      expect(customer.errors.messages[:phone]).must_equal ["can't be blank"]
    end
  end

  describe "relationships" do
  end
end
