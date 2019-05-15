require "test_helper"

describe MoviesController do
  describe "index" do
    before do
      get movies_path
    end
    it "will get a 200 ok response" do
      must_respond_with :ok
    end

    it "response will be json" do
      expect(response["Content-Type"]).must_include "json"
    end

    it "response will be a Array" do
      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Array
    end

    it "return all the movies" do
      body = JSON.parse(response.body)
      expect(body.length).must_equal Movie.count
    end

    it "0 movies returns an empty array w/ ok status" do
      Rental.destroy_all
      Movie.destroy_all
      get movies_path
      must_respond_with :ok
      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Array
      expect(body).must_equal []
    end

    it "returns pets with exactly the required fields" do
      req_fields = %w(id title release_date)
      body = JSON.parse(response.body)
      body.each do |movie|
        expect(movie.keys.sort).must_equal req_fields.sort
      end
    end
  end

  describe "show" do
    let(:movie) { movies(:movie_1) }
    before do
      get movie_path(movie.id)
    end
    it "will get a 200 ok response" do
      must_respond_with :ok
    end

    it "response will be json" do
      expect(response["Content-Type"]).must_include "json"
    end

    it "response will be a hash" do
      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
    end

    it "returns 1 movies" do
      body = JSON.parse(response.body)
      expect(body["title"]).must_equal movie.title
    end

    it "returns pets with exactly the required fields" do
      req_fields = ["available_inventory", "id", "inventory", "overview", "release_date", "title"]
      body = JSON.parse(response.body)
      expect(body.keys.sort).must_equal req_fields.sort
    end
  end

  describe "create" do
    let(:movie_data) {
      {
        "title": "Totally Legit Movie Title",
        "overview": "It's a totally legit movie.",
        "release_date": Date.current,
        "inventory": 10,
      }
    }

    it "creates a new movie given valid data" do
      expect {
        post movies_path, params: movie_data
      }.must_change "Movie.count", 1

      must_respond_with :success

      expect(response.header["Content-Type"]).must_include "json"

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"
    end

    it "returns an error for invalid movie data" do
      movie_data["title"] = nil

      expect {
        post movies_path, params: movie_data
      }.wont_change "Movie.count"

      must_respond_with :bad_request

      expect(response.header["Content-Type"]).must_include "json"

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "title"
    end
  end
end
