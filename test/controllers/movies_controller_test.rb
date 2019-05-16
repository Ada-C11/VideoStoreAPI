require "test_helper"

describe MoviesController do
  describe "Index" do
    it "can show all movies" do
      get movies_path

      must_respond_with :ok
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
      keys = %w( id release_date title )

      get movies_path

      body = JSON.parse(response.body)

      body.each do |movie|
        movie.keys.sort.must_equal keys
        movie.keys.length.must_equal keys.length
      end
    end
  end

  describe "Show" do
    it "can get a movie" do
      get movie_path(movies(:two))

      must_respond_with :ok
    end

    it "returns a BAD REQUEST and is returned as JSON if a movie can't be found" do
      get movie_path(-1)

      must_respond_with :bad_request
      expect(response.header["Content-Type"]).must_include "json"

      body = JSON.parse(response.body)

      expect(body["error"]).must_equal "Unable to find movie"
    end
  end

  describe "Create" do
    let(:movie_data) {
      {
        title: "Rush Hour 2",
        overview: "best movie ever",
        release_date: Date.new(2001, 11, 2),
        inventory: 5,
      }
    }

    let(:avail_movie_data) {
      {
        title: "Rush Hour 2",
        overview: "best movie ever",
        release_date: Date.new(2001, 11, 2),
        inventory: 5,
        available_inventory: 3,
      }
    }
    it "can create a new movie using good data" do
      expect {
        post movies_path, params: {movie: movie_data}
      }.must_change "Movie.count", +1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      movie = Movie.find(body["id"].to_i)

      expect(movie.title).must_equal movie_data[:title]
      expect(movie.available_inventory).must_equal movie.inventory
      must_respond_with :success
    end

    it "can set specific available inventory" do
      expect {
        post movies_path, params: {movie: avail_movie_data}
      }.must_change "Movie.count", +1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      movie = Movie.find(body["id"].to_i)

      expect(movie.title).must_equal movie_data[:title]
      expect(movie.available_inventory).must_equal avail_movie_data[:available_inventory]
      must_respond_with :success
    end

    it "does not create a new movie, and returns BAD REQUEST if given bad data" do
      movie_data["title"] = nil

      expect {
        post movies_path, params: {movie: movie_data}
      }.wont_change "Movie.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "title"
      must_respond_with :bad_request
    end
  end
end
