# frozen_string_literal: true

require "test_helper"
require "pry"

describe RentalsController do
  describe "checkin" do
    before do
      @rental = rentals(:one)
      @rental_params = { rental: { movie_id: @rental.movie_id, customer_id: @rental.customer_id } }
      @customer = Customer.find_by(id: @rental.customer_id)
      p @rental
      @movie = Movie.find_by(id: @rental.movie_id)
    end

    it "decrements customer's checked_out_count" do
      old_customer_value = @customer.movies_checked_out_count
      old_movie_value = @movie.available_inventory
      post checkin_path, params: @rental_params
      @customer.reload
      @movie.reload

      expect(@customer.movies_checked_out_count).must_equal old_customer_value - 1
      expect(@movie.available_inventory).must_equal old_movie_value + 1
    end

    it "won't change the count in the db" do
      expect {
        post checkin_path, params: @rental_params
      }.wont_change "Rental.count"
    end

    it "sets the checked_in value to true" do
      post checkin_path, params: @rental_params
      @rental.reload
      expect(@rental.checked_in).must_equal true
    end
  end

  describe "checkout" do
    let(:rental_data) do
      { rental: {
        customer_id: customers(:joe).id,
        movie_id: movies(:one).id,
      } }
    end

    it "must create a new rental" do
      expect do
        post checkout_path, params: rental_data
      end.must_change "Rental.count"
    end

    it "must change the available_inventory of the checked out movie" do
      count = movies(:one).available_inventory

      post checkout_path, params: rental_data

      expect(movies(:one).reload.available_inventory).must_equal count - 1
    end

    it "must change the movies_checked_out count of the customer" do
      count = customers(:joe).movies_checked_out_count

      post checkout_path, params: rental_data

      expect(customers(:joe).reload.movies_checked_out_count).must_equal count + 1
    end

    it "will render error messages if any data is invalid" do
      rental_data[:rental][:customer_id] = nil

      expect {
        post checkout_path params: rental_data
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)
      expect(body["message"]).must_include "customer_id"
    end

    it "will render error message if there is not enough inventory to checkout" do
      movies(:one).available_inventory = 0
      movies(:one).save

      expect {
        post checkout_path, params: rental_data
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)
      expect(body["message"]).must_equal "Not enough copies in inventory"
    end
  end
end
