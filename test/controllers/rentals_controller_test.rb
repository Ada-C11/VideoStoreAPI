require "test_helper"

describe RentalsController do
  describe "check_in" do
    let(:customer) { customers(:customer1) }
    let(:movie) { movies(:movie1) }
    let(:rental_params) {
      {
        movie_id: movie.id,
        customer_id: customer.id,
      }
    }

    it "should check-in a movie given valid data" do
      expect {
        post check_in_path(rental_params)
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)
      movie.reload

      must_respond_with :success
      expect(body).must_be_kind_of Hash
      expect(body.keys).must_include "check_in_date"
      expect(body["check_in_date"]).must_equal Date.current.to_s
    end

    it "responds with bad request given invalid data" do
      rental_params[:customer_id] = nil

      expect {
        post check_in_path(rental_params)
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)
      movie.reload

      must_respond_with :bad_request
      expect(body).must_be_kind_of Hash
      expect(body.keys).must_include "errors"
      expect(body["errors"]).must_equal ["Rental not found"]
    end
  end

  describe "check_out" do
    it "checks out a movie" do
      rental_params = {
        customer_id: customers(:customer1).id,
        movie_id: movies(:movie1).id,
      }

      expect {
        post check_out_path(rental_params)
      }.must_change "Rental.count", +1
    end

    it "does not check out for a customer that does not exist" do
      rental_params = {
        customer_id: -1,
        movie_id: movies(:movie1).id,
      }

      expect {
        post check_out_path(rental_params)
      }.wont_change "Rental.count"
    end

    it "does not check out for a movie that does not exist" do
      rental_params = {
        customer_id: customers(:customer1).id,
        movie_id: -1,
      }

      expect {
        post check_out_path(rental_params)
      }.wont_change "Rental.count"
    end

    it "does not check out for movie with inventory of 0" do
      no_movies = Movie.create(title: "titanic", overview: "movie", release_date: Date.today, inventory: 0)

      rental_params = {
        customer_id: customers(:customer1).id,
        movie_id: no_movies.id,
      }

      expect {
        post check_out_path(rental_params)
      }.wont_change "Rental.count"
    end
  end

  describe "check in and check out" do
    let(:rental_params) {
      {
        customer_id: customers(:customer1).id,
        movie_id: movies(:movie1).id,
      }
    }

    it "changes movies checked out count when check out for customer" do
      start_movies_count = customers(:customer1).movies_checked_out_count

      post check_out_path(rental_params)
      end_movies_count = Customer.find_by(id: customers(:customer1).id).movies_checked_out_count

      expect(end_movies_count).must_equal start_movies_count + 1
    end

    it "changes movies checked out count when check in for customer" do
      start_movies_count = customers(:customer1).movies_checked_out_count

      post check_out_path(rental_params)
      mid_movies_count = Customer.find_by(id: customers(:customer1).id).movies_checked_out_count
      post check_in_path(rental_params)
      end_movies_count = Customer.find_by(id: customers(:customer1).id).movies_checked_out_count

      expect(mid_movies_count).must_equal start_movies_count + 1
      expect(end_movies_count).must_equal start_movies_count
    end

    it "changes available inventory when check in and check out for movie" do
      start_inventory = movies(:movie1).available_inventory

      post check_out_path(rental_params)
      mid_inventory = Movie.find_by(id: movies(:movie1).id).available_inventory
      post check_in_path(rental_params)
      end_inventory = Movie.find_by(id: movies(:movie1).id).available_inventory

      expect(mid_inventory).must_equal start_inventory - 1
      expect(end_inventory).must_equal start_inventory
    end

  end
end
