require "test_helper"

describe MoviesController do
  let(:movie) { movies(:wild) }
  describe "index" do
    it "should get index" do
      get movies_path

      expect(response.header["Content-Type"]).must_include "json"
      must_respond_with :success
    end

    it "returns an Array with all movies" do
      get movies_path

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Array
      expect(body.length).must_equal Movie.count
    end

    it "returns movies with exactly the required fields" do
      keys = %w(id release_date title)

      get movies_path

      body = JSON.parse(response.body)

      body.each do |movie|
        expect(movie.keys.sort).must_equal keys
        expect(movie.keys.length).must_equal keys.length
      end
    end
  end

  describe "show" do
    it "can get a movie" do
      get movie_path(movies(:wild).id)

      must_respond_with :success
      expect(response.header["Content-Type"]).must_include "json"

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash

      expected_keys = ["title", "overview", "release_date", "inventory", "available_inventory"]

      body.keys.each do |key|
        expected_keys.must_include key
      end
    end

    it "will return an error message if movie is not found" do
      id = -1
      get movie_path(id)
      must_respond_with :not_found
    end
  end
  describe "create" do
    let(:movie_data) {
      {
        title: "Big",
        overview: "Being older isn't what it appears",
        release_date: Date.new(1988, 6, 3),
        inventory: 2,
      }
    }

    it "must create a new movie given correct fields" do
      expect {
        post movies_path, params: (movie_data)
      }.must_change "Movie.count", 1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      movie = Movie.find(body["id"].to_i)

      expect(movie.title).must_equal movie_data[:title]
      must_respond_with :success
    end

    it "returns an error for invalid movie data" do
      movie_data["title"] = nil

      expect {
        post movies_path, params: (movie_data)
      }.wont_change "Movie.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "title"
      must_respond_with :bad_request
    end
  end
end
