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

  # it "should get show" do
  #   get movies_show_url
  #   value(response).must_be :success?
  # end

  describe "create" do
    let(:movie_params) {
      {
        movie: {
          title: "Thing",
          overview: "Test",
          release_date: "2019-01-01",
          inventory: 0,
        },
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
      expect(movie.title).must_equal movie_params[:movie][:title]
      must_respond_with :success
    end

    it "returns an error for invalid movie data" do
      movie_params[:movie][:title] = nil

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
end
