require "test_helper"

describe Customer do
  let (:customer) { customers(:one) }
  let (:movie) { movies(:one) }

  it "must be valid given good data" do
    expect(customer).must_be :valid?
  end

  it "requires name, phone, registered_at" do
    required_fields = [:name, :phone, :registered_at]

    required_fields.each do |field|
      customer[field] = nil
      expect(customer.valid?).must_equal false
      customer.reload
    end
  end
  
  it "can have a rental" do
    rental_count = customer.rentals.count
    rental = Rental.create!(
      customer_id: customer.id,
      movie_id: movie.id,
      due_date: DateTime.now,
    )
    expect(rental.customer).must_be_kind_of Customer
    expect(rental.customer.id).must_equal customer.id
    expect(customer.rentals.count).must_equal (rental_count + 1)
  end
end
