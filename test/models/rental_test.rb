require "test_helper"

describe Rental do
  let (:rental) { rentals(:one) }

  it "must be valid given good data" do
    expect(rental.valid?).must_equal true
  end

  it "requires due_date" do
    required_fields = [:due_date]

    rental.due_date = nil
    expect(rental.valid?).must_equal false
    rental.reload
  end
  
  it "cannot be created with an invalid customer" do
    params = {
      due_date: DateTime.now,
      movie_id: movies(:one).id,
      customer_id: -1,
    }
    
    expect { Rental.new(params) }.wont_change "Rental.count"
  end
end
