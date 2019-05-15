require "test_helper"

describe MoviesController do
  let(:movie) { movies(:harrypotter) }

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

  describe "show" do
    it "can get a movie" do
      get movie_path(movie.id)
      must_respond_with :success
    end

    it "responds with error code and message if not found" do
      invalid_id = -1
      get movie_path(invalid_id)
      must_respond_with :not_found
      body = JSON.parse(response.body)
      body.keys.first.must_equal "errors"
      expect(body["errors"]).must_include "Movie with ID #{invalid_id} not found"
    end

    it "returns json" do
      get movie_path(movie.id)
      expect(response.header["Content-Type"]).must_include "json"
    end

    it "returns a single Hash" do
      get movie_path(movie.id)

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
    end

    it "returns movie with exactly the required fields and correct title" do
      keys = %w(title overview release_date inventory)
      get movie_path(movie.id)
      body = JSON.parse(response.body)
      body.keys.must_equal keys
      body["title"].must_equal "Harry Potter and the Sorcerer's Stone"
    end
  end
end
