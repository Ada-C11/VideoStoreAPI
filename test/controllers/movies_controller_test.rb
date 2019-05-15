require "test_helper"

describe MoviesController do
  describe "index" do
    it "should get index route" do
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
      keys = %w(id release_date title)
      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end
  end

  describe "create" do
    let(:movie_params) {
      {
        title: "Thing",
        overview: "Test",
        release_date: "2019-01-01",
        inventory: 0,
      }
    }

    it "should create a new movie given valid data" do
      expect {
        post movies_path(movie_params)
      }.must_change "Movie.count", 1

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      movie = Movie.find(body["id"].to_i)
      expect(movie.title).must_equal movie_params[:title]
      must_respond_with :success
    end

    it "returns an error for invalid movie data" do
      movie_params[:title] = nil

      expect {
        post movies_path(movie_params)
      }.wont_change "Movie.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "title"
      expect(body["errors"]["title"]).must_equal ["can't be blank"]
      must_respond_with :bad_request
    end
  end

  describe "show" do
    it "returns a movie with exactly require fields" do
      keys = %w(available_inventory inventory overview release_date title)
      get movie_path(movies(:movie1))
      body = JSON.parse(response.body)
      body.keys.sort.must_equal keys
    end

    it "should get movie details route with correct information" do
      get movie_path(movies(:movie1))
      body = JSON.parse(response.body)
      body["title"].must_equal movies(:movie1).title
      body["overview"].must_equal movies(:movie1).overview
      body["inventory"].must_equal movies(:movie1).inventory
      must_respond_with :success
    end

    it "should not show details for a movie that does not exist" do
      get movie_path(-1)
      must_respond_with :bad_request
    end
  end
end
