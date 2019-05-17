require "test_helper"
require "pry"

describe Rental do
  describe "validations" do
    it "must be a valid rental" do
      rental = Rental.new(customer_id: customers(:one).id, movie_id: movies(:two).id)
      rental.save
      rental.valid?.must_equal true
    end
  end

  describe "relations" do
    it "belongs_to movie" do
      rental = rentals(:one)
      rental.movie.must_equal movies(:GreenMile)
    end

    it "belongs_to customer" do
      rental = rentals(:one)
      rental.customer.must_equal customers(:one)
    end
  end

  describe "checkout_update_movies_customers" do
    it "increases customer's movies checked out count by 1" do
      rental = rentals(:one)
      initial_movies_checked_out = rental.customer.movies_checked_out_count
      rental.checkout_update_customer_movie(rental.customer, rental.movie)
      rental.reload
      expect(rental.customer.movies_checked_out_count).must_equal initial_movies_checked_out + 1
    end

    it "decreases movie's available inventory by 1" do
      rental = rentals(:one)
      initial_available_inventory = rental.movie.available_inventory
      rental.checkout_update_customer_movie(rental.customer, rental.movie)
      rental.reload
      expect(rental.movie.available_inventory).must_equal initial_available_inventory - 1
    end
  end

  describe "checkin_update_movies_customers" do
    it "decreases customer's movies checked out count by 1" do
      rental = rentals(:one)
      initial_movies_checked_out = rental.customer.movies_checked_out_count
      rental.checkin_update_customer_movie(rental.customer, rental.movie)
      rental.reload
      expect(rental.customer.movies_checked_out_count).must_equal initial_movies_checked_out - 1
    end

    it "increases movie's available inventory by 1" do
      rental = rentals(:one)
      initial_available_inventory = rental.movie.available_inventory
      rental.checkin_update_customer_movie(rental.customer, rental.movie)
      rental.reload
      expect(rental.movie.available_inventory).must_equal initial_available_inventory + 1
    end
  end
end
