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
end
