require "test_helper"

describe MoviesController do
  describe "index" do
    it "movies_path is a working route" do
      get movies_path
      must_respond_with :success
    end

    it "returns json" do
      get movies_path
      expect(response.header["Content-Type"]).must_include "json"
    end

    it "returns an array" do
      get movies_path
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all movies" do
      get movies_path
      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns movie with the fields required to be included in the json" do
      keys = %w(id title overview release_date inventory)
      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.must_equal keys
      end
    end

    it "return 'no customer' message if there are no customers" do
      Movie.destroy_all
      get movies_path
      # binding.pry
      must_respond_with :success
      expect(JSON.parse(response.body)["message"]).must_equal "There are currently no movies."
    end
  end

  describe "show" do
    it "can get a movie" do
      this_movie = movies(:GreenMile)
      get movie_path(this_movie)
      must_respond_with :success
      this_movie.title.must_equal "The Green Mile"
    end

    it "returns json" do
      # get movies_path
      # expect(response.header["Content-Type"]).must_include "json"
    end

    it "returns an array" do
      # get movies_path
      # body = JSON.parse(response.body)
      # body.must_be_kind_of Array
    end

    it "returns movie with the fields required to be included in the json" do
      # keys = %w(id title overview release_date inventory)
      # get movies_path
      # body = JSON.parse(response.body)
      # body.each do |movie|
      #   movie.keys.must_equal keys
      # end
    end

    it "returns 404 if movie is not found" do
    end
  end

  describe "create" do

  it "makes a new movie" do
  end

  it "returns an error for invalid movie data" do

  end
end
