require "test_helper"

describe Rental do
  let(:rental) { Rental.new(customer_id: customers(:chewy).id, movie_id: movies(:one).id) }

  it "must be valid" do
    value(rental).must_be :valid?
  end
end
