require "test_helper"

describe RentalsController do
  let(:rental_data) {
    {
      movie_id: movies(:GreenMile).id,
      customer_id: customers(:one).id,
      checkout_date: Date.today,
      due_date: Date.today + 7,
    }
  }
  describe "checkout" do
    it "should create a rental given valid data" do
      expect {
        post rentals_checkout_path, params: rental_data
      }.must_change "Rental.count", +1

      must_respond_with :success
    end

    it "will return bad request if given invalid data" do
      rental_data[:movie_id] = nil
      expect {
        post rentals_checkout_path, params: rental_data
      }.wont_change "Rental.count"

      must_respond_with :no_content
    end

    it "returns json" do
      post rentals_checkout_path, params: rental_data
      must_respond_with :success
      expect(response.header["Content-Type"]).must_include "json"
    end

    it "returns a hash" do
      post rentals_checkout_path, params: rental_data
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
    end

    it "returns rental record with the fields required to be included in the json" do
      keys = %w(id)
      post rentals_checkout_path, params: rental_data
      body = JSON.parse(response.body)
      body.keys.must_equal keys
    end

    it "updates the customer movies_checked_out_count" do
      initial_checked_out_count = customers(:one).movies_checked_out_count
      post rentals_checkout_path, params: rental_data
      customers(:one).reload
      customers(:one).movies_checked_out_count.must_equal initial_checked_out_count + 1
    end

    it "updates the movie's available_inventory" do
      initial_movie_inventory = movies(:GreenMile).available_inventory
      post rentals_checkout_path, params: rental_data
      movies(:GreenMile).reload
      movies(:GreenMile).available_inventory.must_equal initial_movie_inventory - 1
    end

    it "returns 204 if movie is not found or not provided" do
      rental_data[:movie_id] = -1
      expect { post rentals_checkout_path, params: rental_data }.wont_change "Rental.count"
      must_respond_with :no_content
    end

    it "returns a message and doesn't save the rental if inventory < 1" do
      rental_data[:movie_id] = movies(:two).id
      expect { post rentals_checkout_path, params: rental_data }.wont_change "Rental.count"
      must_respond_with :forbidden
    end

    it "due date is today + 7 days" do
      movie = movies(:GreenMile)
      customer = customers(:two)
      rental_params = {movie_id: movie.id, customer_id: customer.id}
      # binding.pry

      post rentals_checkout_path, params: rental_params
      rental = Rental.find_by(customer_id: customer.id, movie_id: movie.id)
      rental.due_date.must_equal Date.today + 7
    end
  end

  describe "checkin" do
    let(:rental_params) {
      {
        customer_id: customers(:one).id,
        movie_id: movies(:GreenMile).id,
      }
    }

    it "should checkin a movie with valid data" do
      post rentals_checkout_path, params: rental_data
      post rentals_checkin_path, params: rental_params
      must_respond_with :success
    end

    it "will return 204 if the customer doesn't exist" do
      rental_params[:customer_id] = -1
      post rentals_checkin_path, params: rental_params
      must_respond_with :no_content
    end

    it "will return 204 if the movie doesn't exist" do
      rental_params[:movie_id] = -1
      post rentals_checkin_path, params: rental_params
      must_respond_with :no_content
    end

    it "will return 204 if the rental doesn't exist" do
      rental_params[:customer_id] = customers(:two).id
      post rentals_checkin_path, params: rental_params
      must_respond_with :no_content
    end

    it "updates the customer movies_checked_out_count" do
      initial_checked_out_count = customers(:one).movies_checked_out_count

      post rentals_checkin_path, params: rental_params
      customers(:one).reload
      customers(:one).movies_checked_out_count.must_equal initial_checked_out_count - 1
    end

    it "updates the movie's available_inventory" do
      initial_movie_inventory = movies(:GreenMile).available_inventory
      post rentals_checkin_path, params: rental_data
      movies(:GreenMile).reload
      movies(:GreenMile).available_inventory.must_equal initial_movie_inventory + 1
    end

    it "updates the rentals checked in date" do
      post rentals_checkin_path, params: rental_data
      rentals(:one).reload
      rentals(:one).checked_in_date.must_equal Date.today
    end

    it "returns json" do
      post rentals_checkin_path, params: rental_params
      must_respond_with :success
      expect(response.header["Content-Type"]).must_include "json"
    end

    it "returns a hash" do
      post rentals_checkin_path, params: rental_params
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
    end

    it "returns rental record with the fields required to be included in the json" do
      keys = %w(id message)
      post rentals_checkin_path, params: rental_params
      body = JSON.parse(response.body)
      body.keys.must_equal keys
    end
  end
end
