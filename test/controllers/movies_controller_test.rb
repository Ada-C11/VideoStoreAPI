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
    before do
      @this_movie = movies(:GreenMile)
    end
    it "can get a movie" do
      get movie_path(@this_movie)
      must_respond_with :success
      @this_movie.title.must_equal "The Green Mile"
    end

    it "returns json" do
      get movie_path(@this_movie)
      expect(response.header["Content-Type"]).must_include "json"
    end

    it "returns an Hash" do
      get movie_path(@this_movie)
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
    end

    it "returns movie with the fields required to be included in the json" do
      keys = %w(id title overview release_date inventory)
      get movie_path(@this_movie)
      body = JSON.parse(response.body)
      body.keys.must_equal keys
    end

    it "returns 404 if movie is not found" do
      get movie_path(-1)
      expect(response.header["Content-Type"]).must_include "json"
      must_respond_with :not_found
      body = JSON.parse(response.body)
      body.must_include "error"
    end
  end

  describe "create" do
    let(:movie_params) {
      {
        title: "Stardust",
        inventory: 10,
        release_date: "20191010",
        overview: "fantasy world star falls to earth and adventures ensue",
      }
    }
    it "makes a new movie" do
      expect {
        post movies_path, params: movie_params
      }.must_change "Movie.count", +1
    end

    it "returns an error for invalid movie data" do
      movie_params[:title] = nil
      expect {
        post movies_path, params: movie_params
      }.wont_change "Movie.count"
      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_include "errors"
    end

    it "returns json" do
      post movies_path, params: movie_params
      expect(response.header["Content-Type"]).must_include "json"
    end

    it "returns an Hash" do
      post movies_path, params: movie_params
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
    end

    it "returns movie with the fields required to be included in the json" do
      keys = ["id"]
      post movies_path, params: movie_params
      body = JSON.parse(response.body)
      body.keys.must_equal keys
    end
  end
end
