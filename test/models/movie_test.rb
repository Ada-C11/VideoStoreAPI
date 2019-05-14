require "test_helper"

describe Movie do
  let(:movie) { movies(:movie_1) }

  it "must be valid given complete validations" do
    expect(movie.valid?).must_equal true
  end

  describe "validations" do
    it "will not be valid if missing title" do
      movie.title = nil
      expect(movie.valid?).must_equal false
    end

    it "will not be valid if missing overview" do
      movie.overview = nil
      expect(movie.valid?).must_equal false
    end

    it "will not be valid if missing release_date" do
      movie.release_date = nil
      expect(movie.valid?).must_equal false
    end

    it "will not be valid if missing inventory" do
      movie.inventory = nil
      expect(movie.valid?).must_equal false
    end

    it "will not be valid if missing  available_inventory" do
      movie.available_inventory = nil
      expect(movie.valid?).must_equal false
    end
  end

  describe "relationships" do
    describe "rentals, has_many" do
      it "can have 0 rentals" do
        movie = movies(:movie_3)
        expect(movie.rentals).must_equal []
      end

      it "can have 1 or more rentals" do
        expect(movie.rentals).must_equal [rentals(:rental_1)]
        rental = Rental.new()
        movie.rentals << rental
        customers(:customer_2).rentals << rental
        expect(movie.rentals.sort).must_equal [rentals(:rental_1), rental].sort
      end
    end

    describe "customers, many/through" do
      it "can have 0 customers" do
        movie = movies(:movie_3)
        expect(movie.customers).must_equal []
      end

      it "can have 1 or more customers" do
        expect(movie.customers).must_equal [customers(:customer_1)]
        rental = Rental.new()
        movie.rentals << rental
        customers(:customer_2).rentals << rental
        movie.reload
        expect(movie.customers.sort).must_equal [customers(:customer_1), customers(:customer_2)].sort
      end
    end
  end
end
