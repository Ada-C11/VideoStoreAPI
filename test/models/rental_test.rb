require "test_helper"

describe Rental do
  let(:rental) {
    rentals(:one)
  }

  it "must be valid" do
    expect(rental).must_be :valid?
  end

  describe "availability" do
    let(:rental_two) {
      Rental.new(
        movie_id: movies(:other_test).id,
        customer_id: customers(:shelley).id,
        checkout: DateTime.now,
        due: DateTime.now + 7.days,
      )
    }
    it "won't be valid if movie is unavailable" do
      rental_two.movie.inventory = 0
      value(rental_two).wont_be :valid?
    end
  end
end
