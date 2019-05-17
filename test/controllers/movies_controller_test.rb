require "test_helper"

describe MoviesController do
  let(:movie) { movies(:test) }
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end
  describe "index" do
    # These tests are a little verbose - yours do not need to be
    # this explicit.
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
      keys = %w(id inventory overview release_date title)
      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end
  end

  describe "show" do
    # This bit is up to you!
    it "can get a movie" do
      get movie_path(movie)
      must_respond_with :success
    end

    it "will error if the movie id doesn't exist" do
      get movie_path(-1)
      must_respond_with :not_found

      body = JSON.parse(response.body)

      expect(body).must_include "errors"
      expect(body["errors"][0]["id"]).must_equal "The movie you are looking for with id -1  was not found"
    end
  end

  describe "create" do
    let(:movie_data) {
      {
        title: "Babe: Pig in the City",
        overview: "little pig big city",
        release_date: DateTime.now,
        inventory: 5,
      }
    }

    it "creates a new movie given valid data" do
      expect {
        post movies_path, params: movie_data
      }.must_change "Movie.count", 1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "title"

      movie = Movie.find_by(title: body["title"])

      expect(movie.title).must_equal movie_data[:title]
      must_respond_with :success
    end

    it "returns an error for invalid movie data" do
      # arrange
      movie_data["title"] = nil

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
