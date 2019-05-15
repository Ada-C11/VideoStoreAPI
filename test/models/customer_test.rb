require "test_helper"

describe Customer do
  let(:customer) { Customer.new(name: "meee") }

  it "must be valid" do
    value(customer.valid?).must_equal true
  end

  describe "relations" do
    let(:customer_one) { customers(:one) }
    it "can have one or many rentals" do
      test_rental = rentals(:one)
      other_rental = rentals(:two)

      customer.rentals << test_rental
      customer_one.rentals << other_rental

      expect(test_rental.customer).must_equal customer
      expect(other_rental.customer).must_equal customer_one
    end

    it "can have one or many movies through rentals" do
      new_movie = Movie.create(title: "happy days", overview: "lalala", release_date: Date.today, inventory: 12)
      customer_one.movies << new_movie

      expect(new_movie.customers).must_include customer_one
    end
  end

  describe "validations" do
    it "requires a name" do
      customer.name = nil
      valid_customer = customer.valid?

      expect(valid_customer).must_equal false
      expect(customer.errors.messages).must_include :name
    end
  end

  describe "custom methods" do
    let(:rental_data) {
      {
        customer_id: Customer.first.id,
        movie_id: Movie.first.id,
      }
    }
    it "returns a value for movies_checked_out_count" do
      Rental.destroy_all
      movie = Movie.first
      customer = Customer.first
      rental = Rental.new(rental_data)
      rental.prepare_for_checkout

      expect(customer.movies_checked_out_count).must_equal 1
    end

    it "returns a value that takes into account rentals that have been checked back in for movies_checked_out_count" do
      Rental.destroy_all
      movie = Movie.first
      customer = Customer.first
      rental = Rental.new(rental_data)
      rental.prepare_for_checkout
      rental.currently_checked_out = false

      rental.save
      expect(customer.movies_checked_out_count).must_equal 0
    end
  end
end
