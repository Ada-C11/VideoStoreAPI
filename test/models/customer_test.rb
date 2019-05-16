require "test_helper"

describe Customer do
  let(:customer) { Customer.new }
  let(:valid_customer) { customers(:bob) }

  it "must be valid" do
    expect(valid_customer).must_be :valid?
  end

  it "requires a name" do
    expect(customer.valid?).must_equal false
  end

  describe "increase_checked_out_count" do
    it "increases the customer checked_out_count by 1" do
      before_count = valid_customer.movies_checked_out_count

      valid_customer.increase_checked_out_count
      after_count = valid_customer.movies_checked_out_count

      expect(after_count).must_equal before_count + 1
    end
  end
end
