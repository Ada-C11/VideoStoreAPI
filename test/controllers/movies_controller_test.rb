require "test_helper"

describe MoviesController do
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

    it "returns all of the pets" do
      get movies_path

      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "returns pets with exactly the required fields" do
      keys = %w(id release_date title)
      get movies_path
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal keys
      end
    end
  end

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

  describe "create" do
    let(:movie_data) {
      {
        title: "Pirates of the Caribbean",
        inventory: 2,
        overview: "The adventures of pirates",
        release_date: "2003-06-28",
      }
    }

    it "creates a new movie given valid data" do
      expect {
        post movies_path, params: {movie: movie_data}
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
