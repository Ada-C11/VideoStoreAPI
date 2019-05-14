require "test_helper"

describe Customer do
  let(:customer) { customers(:sontag) }

  describe "validations" do

    it "is valid with all all fields present" do
      expect(customer).must_be :valid?
    end

    it "is invalid without a name" do
      customer.name = ""
    expect(customer).wont_be :valid?
      customer.name = nil
    expect(customer).wont_be :valid?
    end

    end

    describe "relations" do

      it 'has a list of rentals associated with the account' do
        customer.must_respond_to :rentals
        customer.rentals.count.must_equal 1
        customer.rentals.each do |rental|
          rental.must_be_kind_of Rental
        end
      end

      it "returns empty array if no rentals" do
        customer2 = customers(:laverne)
        expect(customer2.rentals).must_equal []
      end

    end
  end
end
