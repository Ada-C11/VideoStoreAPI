require "test_helper"

describe MoviesController do
  describe "index" do
    it "can render without crashing" do
      get movies_path

      must_respond_with :ok
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

    it "returns all of the customers" do
      get movies_path

      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns customers with exactly the required fields" do
      keys = %w(available_inventory id inventory overview release_date title)
      get movies_path
      body = JSON.parse(response.body)
      body.each do |movies|
        movies.keys.sort.must_equal keys
      end
    end
  end

  describe "show" do
    before do
      @movie = movies(:blacksmith)
    end
    it "can get a movie" do
      get movie_path(@movie)

      must_respond_with :success
    end

    it "returns a movie with the required fields" do
      keys = %w(available_inventory id inventory overview release_date title)

      get movie_path(@movie.id)

      body = JSON.parse(response.body)
      body.keys.sort.must_equal keys
    end

    it "still returns JSON if the movie is bogus" do
      get movie_path(id: -1)
      expect(response.header["Content-Type"]).must_include "json"
    end

    it "returns not_found for a nonexistant movie" do
      get movie_path(id: -1)
      must_respond_with :not_found
    end

    it "still returns JSON if the request is bad" do
      get movie_path("bad data")
      expect(response.header["Content-Type"]).must_include "json"
    end

    describe "create" do
      let(:movie_data) {
        {
          title: "Test Story",
          overview: "Two people test their code for homework",
          release_date: 2019 - 01 - 18,
          inventory: 3,
        }
      }

      it "creates a new movie given valid data" do
        expect {
          post movies_path, params: movie_data
        }.must_change "Movie.count", 1

        body = JSON.parse(response.body)
        expect(body).must_be_kind_of Hash
        expect(body).must_include "id"

        new_movie = Movie.find(body["id"].to_i)
        expect(new_movie.title).must_equal movie_data[:title]
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

  # it "should get zomg" do
  #   get movies_zomg_url
  #   value(response).must_be :success?
  # end

end
