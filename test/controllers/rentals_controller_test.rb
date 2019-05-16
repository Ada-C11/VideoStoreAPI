require "test_helper"

describe RentalsController do
  let(:valid_movie) { movies(:blacksmith) }
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
