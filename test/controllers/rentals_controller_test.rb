require "test_helper"

describe RentalsController do
  describe "Checkin" do
    let(:movie) { movies(:one) }
    let(:customer) { customers(:one) }
    let(:rental_data) {
      {
        movie_id: movie.id,
        customer_id: customer.id,
      }
    }
    it "should pass given valid data" do
      post checkin_path, params: {rental: rental_data}

      value(response).must_be :success?
      expect(response.header["Content-Type"]).must_include "json"

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      rental = Rental.find(body["id"].to_i)
      expect(rental.customer_id).must_equal rental_data[:customer_id]
      expect(rental.movie_id).must_equal rental_data[:movie_id]
    end

    it "throws an error and returns BAD REQUEST if given invalid data" do
      bad_data = {
        rental: {
          movie_id: movie.id,
          customer_id: -1,
        },
      }
      post checkin_path, params: {rental: bad_data}
      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Array
      expect(body[0]).must_include "errors"
      expect(body[0]["errors"]).must_include "rental"
      must_respond_with :not_found

      describe "Checkout" do
        let(:movie) { movies(:two) }
        let(:customer) { customers(:two) }
        let(:rental_data) {
          {
            movie_id: movie.id,
            customer_id: customer.id,
          }
        }

        it "creates a Rental and sets a due date" do
          expect {
            post checkout_path, params: {rental: rental_data}
          }.must_change "Rental.count", 1

          must_respond_with :success
        end

        it "creates a due date" do
          post checkout_path, params: {rental: rental_data}

          body = JSON.parse(response.body)
          expect(body).must_be_kind_of Hash
          expect(body).must_include "id"

          rental = Rental.find(body["id"].to_i)

          expect(rental.due_date).wont_be_nil
          expect(rental.due_date).must_be_kind_of DateTime

          expect(rental.movie.id).must_equal rental_data[:movie_id]
        end

        it "renders as JSON" do
          post checkout_path, params: {rental: rental_data}

          expect(response.header["Content-Type"]).must_include "json"
        end

        it "returns a customer ID and movie ID" do
          post checkout_path, params: {rental: rental_data}

          body = JSON.parse(response.body)

          expect(body).must_include "customer_id"
          expect(body).must_include "movie_id"
        end

        it "displays errors if a rental can't be created" do
          bad_data = {
            rental: {
              movie_id: -5,
              customer_id: customer.id,
            },
          }

          expect {
            post checkout_path, params: bad_data
          }.wont_change "Rental.count"

          body = JSON.parse(response.body)

          expect(body).must_be_kind_of Hash
          expect(body).must_include "errors"
          expect(body["errors"]).must_include "movie"

          must_respond_with :bad_request
        end
      end
    end
  end
end
