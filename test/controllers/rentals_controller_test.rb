require "test_helper"

describe RentalsController do
  describe "checkout" do 
    let(:rental_data) { 
        rental_data = { 
          movie_id: movies(:movie_one).id, 
          customer_id: customers(:jose).id 
        } 
      }

    it "when checked out it adds a rental record to the rental table" do 
  
      expect{
        post checkout_path, params: rental_data
      }.must_change "Rental.count", +1
      
      body = JSON.parse(response.body)

      must_respond_with :ok
      expect(response.header["Content-Type"]).must_include "json"
      expect(body.keys).must_equal %w(id movie_id customer_id due_date)
    end

    it "when checked out decreases inventory by one" do
      
      expect {
        post checkout_path, params: rental_data
      }.must_change "Movie.find(rental_data[:movie_id]).available_inventory", -1

      must_respond_with :success
    end

    # nominal failure cases
    it "will not checkout a movie with 0 available inventory" do 
      cant_rent_data = { 
          movie_id: movies(:unavailable_movie).id, 
          customer_id: customers(:jose).id 
        }
      expect{
        post checkout_path, params: cant_rent_data
      }.wont_change "Rental.count"
      
      body = JSON.parse(response.body)
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "Could not create rental request"
      
      expect{
        post checkout_path, params: cant_rent_data
      }.wont_change "Movie.find(cant_rent_data[:movie_id]).available_inventory"

      must_respond_with :bad_request
    end

    # edge failure
    it "will not check out a non existant (bogus) movie" do 
      rental_no_movie = { 
          movie_id: -1, 
          customer_id: customers(:jose).id 
        }

      expect{
        post checkout_path, params: rental_no_movie
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "Could not create rental request"
    end

    it "will not check out a non existant (bogus) customer" do 
      rental_no_customer = { movie_id: movies(:unavailable_movie).id, 
          customer_id: -1
        }

        expect{
          post checkout_path, params: rental_no_customer
        }.wont_change "Rental.count"

      body = JSON.parse(response.body)
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "Could not create rental request"
    end

    # edge success
    # it "will allow a movie to be checked out on the same day it is checked back in" do 
    #   skip
    #   post checkout_path, params: rental_data
    #   # must be same movie
    #   patch checkin_path, params: checkin_data
    #   post checkout_path, params: rental_data
      
    #   must_respond_with :success
    # end
  end

  describe "checkin" do
    let(:customer1) { customers(:skyler) }
    let(:movie1) { movies(:movie_two) }
    let(:rental_data1) {
      {
        movie_id: movie1.id,
        customer_id: customer1.id,
      }
    }

   
    let(:customer2) { customers(:jose) }
    let(:movie2) { movies(:movie_one) }
    let(:rental_data2) {
      {
        movie_id: movie2.id,
        customer_id: customer2.id,
      }
    }

    let(:rental_data3) {
      {
        movie_id: "dog",
        customer_id: customer2.id,
      }
    }

    it "can checkin a movie if inventory is greater than available inventory" do
      expect {
        post checkin_path, params: rental_data1
      }.must_change "Movie.find(rental_data1[:movie_id]).available_inventory", +1

      must_respond_with :success
    end

    it "can't checkin a movie if inventory equals available inventory" do
      expect {
        post checkin_path, params: rental_data2
      }.wont_change "Movie.find(rental_data1[:movie_id]).available_inventory"

      must_respond_with :bad_request
    end

    it "can't checkin a non existent movie" do
      post checkin_path, params: rental_data3

      must_respond_with :not_found
    end
  end
end
