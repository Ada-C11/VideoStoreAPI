require "test_helper"

describe Movie do
  let (:movie) { movies(:one) }
  let (:customer) { customers(:one) }
  let (:rental) {
    Rental.new(
      customers_id: customer.id,
      movies_id: movie.id,
      due_date: DateTime.now,
    )
  }

  it "must be valid given good data" do
    expect(movie.valid?).must_equal true
  end

  it "requires title, inventory" do
    required_fields = [:title, :inventory]

    required_fields.each do |field|
      movie[field] = nil
      expect(movie.valid?).must_equal false
      movie.reload
    end
  end

  it "can have a rental" do
    movie = Movie.first
    customer = Customer.first
    rental = Rental.create!(
      customer_id: customer.id,
      movie_id: movie.id,
      due_date: DateTime.now,
    )
    expect(rental.valid?).must_equal true
    expect(movie.rentals.first.id).must_equal rental.id
  end
end
