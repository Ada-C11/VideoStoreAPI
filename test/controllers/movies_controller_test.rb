require "test_helper"

describe MoviesController do
  describe "index" do
    it "is a real working route" do
      get movies_path
      must_respond_with :success
    end

    it "returns json" do
      get movies_path
      expect(response.header["Content-Type"]).must_include "json"
    end

    it "returns an Array" do
      get movies_path

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the movies" do
      get movies_path

      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "returns movies with exactly the required fields" do
      keys = %w(id release_date title)
      get movies_path
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal keys
      end
    end
  end

  describe "show" do
    it "can get a movie" do
      get movie_path(movies(:two).id)
      must_respond_with :success
    end

    it "returns correct movie" do
      movie = movies(:two)

      get movie_path(movie.id)

      expect(movie.title).must_equal "MovieTwo"
    end

    it "returns movie with exactly the required fields" do
      movie = movies(:two)

      get movie_path(movie.id)

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      movie = Movie.find(body["id"].to_i)

      expect(movie.title).must_equal movie[:title]
      must_respond_with :success
    end

    it "returns an error if movie does not exist" do
      get movie_path(-1)

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "movie"
      must_respond_with :not_found
    end
  end

  describe "create" do
    let(:movie_data) {
      {
        title: "Pirates of the Caribbean",
        inventory: 2,
        overview: "The adventures of pirates",
        release_date: "2003-06-28",
      }
    }

    it "creates a new movie given valid data" do
      expect {
        post movies_path, params: movie_data
      }.must_change "Movie.count", 1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      movie = Movie.find(body["id"].to_i)

      expect(movie.title).must_equal movie_data[:title]
      must_respond_with :success
    end

    it "returns an error for invalid movie data" do
      # arrange
      movie_data["title"] = nil

      expect {
        post movies_path, params: movie_data
      }.wont_change "Movie.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "title"
      must_respond_with :bad_request
    end
  end

  describe "checkout" do
    let(:rental_data) {
      {
        customer_id: Customer.first.id,
        movie_id: Movie.first.id,
      }
    }

    it "can rent a movie" do
      expect {
        post checkout_path(rental_data)
      }.must_change "Rental.count", +1

      new_rental = Rental.find_by(customer_id: Customer.first.id, movie_id: Movie.first.id)
      # expect(new_rental.checkout_date).must_equal Date.today
      # expect(new_rental.due_date).must_equal Date.today + 7.days
      must_respond_with :success
    end

    it "returns an error for with invalid data" do
      rental_data[:customer_id] = nil

      expect {
        post checkout_path(rental_data)
      }.wont_change "Rental.count"

      must_respond_with :bad_request
    end
  end

  describe "checkin" do
    let(:rental_data) {
      {
        customer_id: Customer.first.id,
        movie_id: Movie.first.id,
      }
    }

    it "returns a 200 ok for successfully checked in rentals" do
      #checkout so that we can checkin
      expect {
        post checkout_path(rental_data)
      }.must_change "Rental.count", +1

      expect {
        post checkin_path(rental_data)
      }.wont_change "Rental.count"

      must_respond_with :success
    end

    it "returns not found for not found rental" do
      expect {
        post checkin_path(rental_data)
      }.wont_change "Rental.count"

      must_respond_with :not_found
    end
  end
end
