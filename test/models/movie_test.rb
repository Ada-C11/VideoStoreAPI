require "test_helper"

describe Movie do
  let(:movie) { Movie.new(title: "meee") }

  it "must be valid" do
    value(movie.valid?).must_equal true
  end

  describe "relations" do
    let(:movie_one) { Movie.first }
    it "can have one or many rentals" do
      test_rental = rentals(:one)
      other_rental = rentals(:two)

      movie.rentals << test_rental
      movie_one.rentals << other_rental

      expect(test_rental.movie).must_equal movie
      expect(other_rental.movie).must_equal movie_one
    end

    it "can have one or many customers through rentals" do
      new_customer = Customer.create(name: "happy days")
      movie_one.customers << new_customer

      expect(new_customer.movies).must_include movie_one
    end
  end

  describe "validation" do
    it "requires a title" do
      movie.title = nil
      valid_movie = movie.valid?

      expect(valid_movie).must_equal false
      expect(movie.errors.messages).must_include :title
    end
  end

  describe "custom methods" do
    let(:rental_data) {
      {
        customer_id: Customer.first.id,
        movie_id: Movie.first.id,
      }
    }

    it "will return correct value for movies_checked out" do
      Rental.destroy_all
      movie = Movie.first
      customer = Customer.first
      rental = Rental.new(rental_data)
      rental.prepare_for_checkout

      expect(movie.available_inventory).must_equal (movie.inventory - 1)
    end
  end
end
