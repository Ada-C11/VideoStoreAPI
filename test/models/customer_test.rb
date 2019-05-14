require "test_helper"
require "pry"

describe Customer do
  let(:customer) { customers(:donald) }

  describe "validations" do
    it "can be created" do
      expect(customer.valid?).must_equal true
    end

    it "requires name, phone number, postal code, and registered at" do
      required_fields = [:name, :phone, :postal_code, :registered_at]
      required_fields.each do |field|
        customer[field] = nil
        expect(customer.valid?).must_equal false
        customer.reload
      end
    end

    it "registered at must be date" do
      customer.registered_at = "hi!"
      expect(customer.valid?).must_equal false
      customer.reload
    end
  end

  describe "custom methods" do
    it "returns 0 for checked out count" do
      expect(customer.movies_checked_out_count).must_equal 0
    end
  end
end
