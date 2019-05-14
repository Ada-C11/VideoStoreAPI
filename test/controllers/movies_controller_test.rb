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

  # it "should get create" do
  #   get movies_create_url
  #   value(response).must_be :success?
  # end


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
