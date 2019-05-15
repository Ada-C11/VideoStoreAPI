require "test_helper"

describe Customer do
  describe "validations" do
    let(:customer) { 
      Customer.create(
        name: "New customer",
        registered_at: Date.current,
        postal_code: 98000,
        phone: 1231231234,
        movies_checked_out_count: 0
      )
    }

    it "passes validations with good data" do
      expect(customer).must_be :valid?
    end

    it "rejects a customer without a name" do
      customer.name = ""
      customer.save
      result = customer.valid?

      expect(result).must_equal false
      expect(customer.errors.messages).must_include :name
    end

    it "rejects a customer without registered_at date" do
      customer.registered_at = ""
      customer.save
      result = customer.valid?

      expect(result).must_equal false
      expect(customer.errors.messages).must_include :registered_at
    end

    it "rejects a customer without a postal code" do
      customer.postal_code = ""
      customer.save
      result = customer.valid?

      expect(result).must_equal false
      expect(customer.errors.messages).must_include :postal_code
    end

    it "rejects a customer without a phone number" do
      customer.phone = ""
      customer.save
      result = customer.valid?

      expect(result).must_equal false
      expect(customer.errors.messages).must_include :phone
    end

    it "rejects a customer without a movies_checked_out_count" do
      customer.movies_checked_out_count = ""
      customer.save
      result = customer.valid?

      expect(result).must_equal false
      expect(customer.errors.messages).must_include :movies_checked_out_count
    end
  end
end
