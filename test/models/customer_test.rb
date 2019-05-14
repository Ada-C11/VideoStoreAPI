require "test_helper"

describe Customer do
  before do
    @customer = customers(:customer_1)
  end

  describe "Validations" do
    it "must be valid with valid data" do
      @customer.must_be :valid?
    end
  
    it "will not be valid without name" do
      @customer.name = nil
      expect(@customer.valid?).must_equal false
    end
  
    it "will not be valid without registered_at" do
      @customer.registered_at = nil
      expect(@customer.valid?).must_equal false
    end
  
    it "will not be valid without postal_code" do
      @customer.postal_code = nil
      expect(@customer.valid?).must_equal false
    end
  
    it "will not be valid without phone" do
      @customer.phone = nil
      expect(@customer.valid?).must_equal false
    end
  end
  
  describe "relations" do
    before do
      @cust_with_no_rental = customers(:customer_2)
    end

    it "can have 0 rental" do
      expect(@cust_with_no_rental.rentals.count).must_equal 0
    end

    it "can have 1 or more rentals" do
      expect(@customer.rentals.count).must_equal 2
    end

    it "can have 0 movie" do
      expect(@cust_with_no_rental.movies.count).must_equal 0
    end

    it "can have 1 or more movie" do
      expect(@customer.movies.count).must_equal 2
    end
  end
end
