require "test_helper"

describe Customer do
  before do
    @customer = customers(:customer_1)
  end

  describe "Validations" do
    it "must be valid with valid data" do
      @customer.must_be :valid?
    end
  
    it "will not be valid without name" do
      @customer.name = nil
      expect(@customer.valid?).must_equal false
    end
  
    it "will not be valid without registered_at" do
      @customer.registered_at = nil
      expect(@customer.valid?).must_equal false
    end
  
    it "will not be valid without postal_code" do
      @customer.postal_code = nil
      expect(@customer.valid?).must_equal false
    end
  
    it "will not be valid without phone" do
      @customer.phone = nil
      expect(@customer.valid?).must_equal false
    end
  end
  
  describe "relations" do
    before do
      @cust_with_no_rental = customers(:customer_2)
    end

    it "can have 0 rental" do
      expect(@cust_with_no_rental.rentals.count).must_equal 0
      expect(@cust_with_no_rental.rentals).must_equal []
    end

    it "can have 1 or more rentals" do
      expect(@customer.rentals.count).must_equal 2
      expect(@customer.rentals.first).must_equal rentals(:rental_1)
      expect(@customer.rentals.last).must_equal rentals(:rental_2)

      new_rental = Rental.new()
      movie = movies(:movie_2)
      movie.rentals << new_rental

      @customer.rentals << new_rental
      @customer.reload
      expect(@customer.rentals.count).must_equal 3
      expect(@customer.rentals.last).must_equal new_rental
    end

    it "can have 0 movie through rentals" do
      expect(@cust_with_no_rental.movies.count).must_equal 0
      expect(@cust_with_no_rental.movies).must_equal []
    end

    it "can have 1 or more movie through rentals" do
      expect(@customer.movies.count).must_equal 2
      expect(@customer.movies.first).must_equal movies(:movie_2)
      expect(@customer.movies.last).must_equal movies(:movie_1)

      new_movie = movies(:movie_3)
      @customer.movies << new_movie
      @customer.reload

      expect(@customer.movies.count).must_equal 3
      expect(@customer.movies.last).must_equal new_movie      
    end
  end
end
