require "test_helper"

describe RentalsController do
  let(:valid_movie) { movies(:blacksmith) }
  let(:unavail_movie) { movies(:savior) }
  let(:valid_customer) { customers(:sarah) }
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
  # it "should get check_out" do
  #   get rentals_check_out_url
  #   value(response).must_be :success?
  # end

  # it "should get check_in" do
  #   get rentals_check_in_url
  #   value(response).must_be :success?
  # end

end
