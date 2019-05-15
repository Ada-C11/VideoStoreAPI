require "test_helper"

describe Rental do
  let(:rental) { rentals(:one) }

  it "requires movie and customer ids" do
    required_fields = [:customer_id, :movie_id]

    required_fields.each do |field|
      rental[field] = nil
      expect(rental.valid?).must_equal false

      rental.reload
    end
  end
end

