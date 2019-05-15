require "test_helper"

describe MoviesController do
  describe "show" do
    it "can show data for a movie that exists" do
      get movie_path(Movie.first.id)
      must_respond_with :success
    end

    it "returns 404 for a movie that doesn't exist" do
      get movie_path(-1)
      must_respond_with :error
      expect(response.header['Content-Type']).must_include 'json'
    end

    it "returns an Hash" do
      get movie_path(Movie.first.id)

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
    end

    it "returns the movie with exactly the required fields" do
      keys = %w(id title release_date)
      get movie_path(Movie.first.id)
      body = JSON.parse(response.body)
      body.keys.must_equal keys
    end
  end

  describe "index" do
    it "is a working route" do
      get movies_path
      must_respond_with :success
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
      keys = %w(id title release_date)
      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.must_equal keys
      end
    end
  end

  describe "create" do
    let(:movie_data) {
      {
        title: "Wandering Earth",
        overview: "The earth is flying around",
        release_date: Date.parse("2019-02-02"),
        inventory: 20,
        available_inventory: 20,
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
      movie_data[:title] = nil

      expect {
        post movies_path, params: { movie: movie_data }
      }.wont_change "Movie.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "title"
      must_respond_with :bad_request
    end
  end
end
