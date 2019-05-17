require "test_helper"

describe MoviesController do
  let(:movie) { movies(:one) }
  describe "index" do
    it "should get index" do
      get movies_path
      must_respond_with :success
    end

    it "should get index if there are no movies" do
      movies = Movie.all

      movies.each do |movie|
        movie.destroy
      end

      get movies_path

      expect(response.header["Content-Type"]).must_include "json"
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
      body.length.must_equal Movie.count
    end

    it "returns movies with exactly the required fields" do
      keys = %w(id release_date title)

      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end
  end

  describe "show" do
    it "returns json" do
      get movie_path(movie.id)
      expect(response.header["Content-Type"]).must_include "json"
    end

    it "should get show" do
      get movie_path(movie.id)
      must_respond_with :success
    end

    it "returns 404 and error message for an invalid movie" do
      get movie_path("invalid_id")

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "error_message"

      must_respond_with :not_found
    end
  end

  describe "create" do
    let(:movie_data) {
      {
        title: "Titanic",
        overview: "movie about a boat",
        release_date: "1990s",
        inventory: 3,
      }
    }
    it "returns json" do
      post movies_path, params: movie_data
      expect(response.header["Content-Type"]).must_include "json"
    end

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
end
