require "test_helper"

describe Customer do
  let(:customer) { customers(:customer2) }
  let(:rental1) { rentals(:rental1) }
  let(:rental2) { rentals(:rental2) }

  it "must be valid" do
    expect(customer.valid?).must_equal true
  end

  it "is not valid without a name" do
    no_name = Customer.new(registered_at: "2019-05-14 12:53:58",
      address: "123 Computer Way",
      city: "Seattle",
      state: "WA",
      postal_code: '98199',
      phone: "512-555-555")
    expect(no_name.valid?).must_equal false
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
