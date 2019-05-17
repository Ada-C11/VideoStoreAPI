require "test_helper"

describe Customer do
  let(:customer) { customers(:shelley) }

  describe "validations" do
    it "must be valid" do
      value(customer).must_be :valid?
    end

    it "won't be valid without a name" do
      customer.name = nil
      value(customer).wont_be :valid?
    end
  end
  describe "relations" do
    it "has associated rentals" do
      expect(customer).must_respond_to :rentals
      expect(customer.rentals).must_include rentals(:one)
      expect(customer.rentals).must_include rentals(:three)
    end
    it "has associated movies" do
      expect(customer).must_respond_to :movies
      expect(customer.movies).must_include movies(:test)
      expect(customer.movies).must_include movies(:other_test)
    end
    it "can return the number of movies currently checked out" do
      expect(customer.checked_out_count).must_equal 1
    end
  end
end
