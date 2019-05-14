require "test_helper"

describe MoviesController do
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
end
