require "test_helper"

describe Customer do
  let(:customer) { customers(:customer2) }
  let(:rental1) { rentals(:rental1) }
  let(:rental2) { rentals(:rental2) }

  it "must be valid" do
    expect(customer.valid?).must_equal true
  end

  describe "relations" do
    it "can have zero rentals" do
      rentals = customer.rentals
      expect(rentals.length).must_equal 0
    end

    it "can have many rentals" do
      rentals = customer.rentals
      rentals.push(rental1, rental2)

      expect(rentals.length).must_equal 2
      expect(rentals).must_include rental1
      expect(rentals).must_include rental2
    end
  end
end
