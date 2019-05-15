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

    it "returns json even if movie is deleted" do
      deleted_movie = movies(:deletedmovie)
      movie_id = deleted_movie.id
      deleted_movie.destroy

      get movie_path(movie_id)
      must_respond_with :not_found
      expect(response.header["Content-Type"]).must_include "json"
    end
  end

  describe "create" do
    let(:movie_data) {
      {
        title: "Movie, the Movie",
        overview: "A movie about a movie.",
        release_date: "2010-05-12",
        inventory: 7,
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
