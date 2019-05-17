require "test_helper"
require "pry"

describe RentalsController do
  let(:valid_movie) { movies(:blacksmith) }
  let(:unavail_movie) { movies(:savior) }
  let(:valid_customer) { customers(:sarah) }
  let(:valid_rental) { rentals(:rental_one) }
  describe "check_out" do
    it "should be able to create a rental with a valid customer and valid movie" do
      before_rental = valid_movie.available_inventory
      rental_hash = {
        rental: {
          customer_id: valid_customer.id,
          movie_id: valid_movie.id,
        },
      }

      expect { post check_out_path, params: rental_hash[:rental] }.must_change "Rental.count", 1

      after_rental = Movie.find_by(id: valid_movie.id)
      expect(after_rental.available_inventory).must_equal before_rental - 1
    end

    it "returns not_found if it can't find a movie" do
      rental_hash = {
        rental: {
          customer_id: valid_customer.id,
          movie_id: "bogus id",
        },
      }

      expect { post check_out_path, params: rental_hash[:rental] }.wont_change "Rental.count"
      must_respond_with :not_found
    end

    it "returns not_found if it can't find a customer" do
      rental_hash = {
        rental: {
          customer_id: "bogus customer",
          movie_id: valid_movie.id,
        },
      }

      expect { post check_out_path, params: rental_hash[:rental] }.wont_change "Rental.count"
      must_respond_with :not_found
    end

    it "responds with bad request if there is no available inventory for specified movie" do
      rental_hash = {
        rental: {
          customer_id: valid_customer.id,
          movie_id: unavail_movie.id,
        },
      }

      expect(unavail_movie.available_inventory).must_equal 0
      expect { post check_out_path, params: rental_hash[:rental] }.wont_change "Rental.count"
      must_respond_with :precondition_failed
    end
  end

  describe "check_in" do
    before do
      @rental_hash = {
        rental: {
          customer_id: valid_customer.id,
          movie_id: valid_movie.id,
        },
      }

      post check_out_path, params: @rental_hash[:rental]
    end
    it "should be able to update a rental with a valid customer and valid movie" do
      rental = Rental.where(customer_id: valid_customer.id, movie_id: valid_movie.id).order(due_date: :asc).first

      before_checkin_inventory = Movie.find_by(id: valid_movie.id).available_inventory
      before_checkin_movies_count = Customer.find_by(id: valid_customer.id).movies_checked_out_count

      expect { post check_in_path, params: @rental_hash[:rental] }.wont_change "Rental.count"

      rental.reload
      after_checkin_movie = Movie.find_by(id: rental.movie_id)
      after_checkin_movies_count = Customer.find_by(id: valid_customer.id).movies_checked_out_count

      expect(rental.check_in).must_be_kind_of ActiveSupport::TimeWithZone
      expect(after_checkin_movie.available_inventory).must_equal before_checkin_inventory + 1
      expect(after_checkin_movies_count).must_equal before_checkin_movies_count - 1
    end

    it "returns not_found if it can't find a rental's customer" do
      rental_hash = {
        rental: {
          customer_id: Customer.all.last.id + 1,
          movie_id: valid_movie.id,
        },
      }

      expect { post check_in_path, params: rental_hash[:rental] }.wont_change "Rental.count"
      must_respond_with :not_found
    end

    it "returns not_found if it can't find a rental's movie" do
      rental_hash = {
        rental: {
          customer_id: valid_customer.id,
          movie_id: "bogus id",
        },
      }

      expect { post check_in_path, params: rental_hash[:rental] }.wont_change "Rental.count"
      must_respond_with :not_found
    end

    it "returns not found if it can't find a rental" do
      rental_hash = {
        rental: {
          customer_id: valid_customer.id,
          movie_id: movies(:treasure).id,
        },
      }

      expect { post check_in_path, params: rental_hash[:rental] }.wont_change "Rental.count"
      must_respond_with :not_found
    end
  end
end
