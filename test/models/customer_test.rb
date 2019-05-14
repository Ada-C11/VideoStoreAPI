require "test_helper"

describe Customer do
  let(:customer) { customers(:chantal) }

  describe "relationships" do
    it "has rentals" do
      expect(customer.rentals).must_respond_to :each
    end
  end

  describe "validations" do
    it "valid customer has a name" do
      expect(customer).must_be :valid?
    end

    it "invalid customer does not have a name" do
      customer.name = nil
      expect(customer).wont_be :valid?
    end
  end
end
