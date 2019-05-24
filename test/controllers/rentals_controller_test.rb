require "test_helper"

describe RentalsController do
  describe "checkout" do
    let(:rental_data) {
      {
        customer_id: customers(:customer_two).id,
        movie_id: movies(:movie_one).id,
        name: customers(:customer_two).name,
        title: movies(:movie_one).title,
        postal_code: customers(:customer_two).postal_code,
      }
    }

    it "creates a new rental given valid data" do
      expect {
        post checkout_path, params: rental_data
      }.must_change "Rental.count", 1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      rental = Rental.find(body["id"].to_i)

      expect(rental.customer_id).must_equal rental_data[:customer_id]
      must_respond_with :success
    end

    it "returns an error for invalid rental data" do
      # arrange
      rental_data["customer_id"] = nil

      expect {
        post checkout_path, params: rental_data
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "customer_id"
      must_respond_with :bad_request
    end

    it "increases customers movies_checked_out_count by 1 when given valid data" do
      customer = customers(:customer_two)

      post checkout_path, params: rental_data

      customer.reload

      expect(customer.movies_checked_out_count).must_equal 1
    end

    it "does not increase customers movies_checked_out_count by 1 when given invalid data" do
      rental_data["customer_id"] = nil

      customer = customers(:customer_two)

      post checkout_path, params: rental_data

      customer.reload

      expect(customer.movies_checked_out_count).must_equal 0
    end

    it "decreases movie available inventory count by 1 when given valid data" do
      movie = movies(:movie_one)

      post checkout_path, params: rental_data

      movie.reload

      expect(movie.available_inventory).must_equal 2
    end

    it "won't decrease movie available inventory count by 1 when given invalid data" do
      rental_data["customer_id"] = nil
      movie = movies(:movie_one)

      post checkout_path, params: rental_data

      movie.reload

      expect(movie.available_inventory).must_equal 3
    end

    it "won't allow a checkout if movie stock is 0 " do
      rental_data["movie_id"] = movies(:movie_three).id

      expect {
        post checkout_path, params: rental_data
      }.wont_change "Rental.count"
    end
  end

  describe "checkin" do
    let(:rental_data) {
      {
        customer_id: customers(:customer_one).id,
        movie_id: movies(:movie_one).id,
      }
    }

    it "it returns an error if rental is not found" do
      rental_data["customer_id"] = customers(:customer_two).id
      expect {
        post checkin_path, params: rental_data
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "Rental not found"
      must_respond_with :bad_request
    end

    it "decreases customers movies_checked_out_count by 1 when given valid data" do
      customer = customers(:customer_one)

      post checkin_path, params: rental_data

      customer.reload

      expect(customer.movies_checked_out_count).must_equal 1
    end
  end

  describe "overdue" do
    it "finds movies that are overdue" do
      rental = rentals(:rental_one)
      get overdue_path
      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Array
      expect(body[0]["customer_id"]).must_equal rental.customer_id
    end

    it "returns an array if there are rentals, but no overdues" do
      rental = rentals(:rental_one)
      rental.destroy

      get overdue_path

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Array
    end

    it "returns a hash if there are no renals (and no overdues)" do
      Rental.destroy_all

      get overdue_path
      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
    end
  end
end
