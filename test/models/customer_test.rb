require "test_helper"

describe Customer do
  let(:customer) { Customer.new }

  describe "relations" do
    it "customer has_many rentals" do
      customer = customers(:two)
      customer.rentals.must_include rentals(:two)
    end
  end
end
