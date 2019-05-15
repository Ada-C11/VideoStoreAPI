require "test_helper"

describe MoviesController do
  describe "index" do
    it "is a working route that returns a JSON array" do
      get movies_path

      must_respond_with :success
      expect(response.header["Content-Type"]).must_include "json"

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.length.must_equal Movie.count
    end

    it "returns correct movie fields" do
      movie_fields = ["id", "inventory", "overview", "release_date", "title"]

      get movies_path
      body = JSON.parse(response.body)

      body.each do |movie|
        movie.keys.sort.must_equal movie_fields
      end
    end

    it "can sort movies by their fields" do
      get movies_path(sort: :title)
      body = JSON.parse(response.body)

      must_respond_with :success
      expect(body.first["title"]).must_equal movies(:one)["title"]

      get movies_path(sort: :release_date)
      body = JSON.parse(response.body)
      expect(body.first["title"]).must_equal movies(:two)["title"]
    end
  end

  describe "show" do
    it "can show a movie provided valid id" do
      get movie_path(movies(:one).id)
      must_respond_with :success
    end

    it "responds with not found for invalid/nonexistant movie" do
      invalid_id = -7
      get movie_path(invalid_id)
      must_respond_with :not_found
    end
  end

  describe "create" do
    let(:movie_data) {
      {
        title: "Pulp Fiction",
        overview: "Friends have fun in LA.",
        release_date: "1994-10-14",
        inventory: 3,
      }
    }

    it "creates new movie provided valid data" do
      expect {
        post movies_path, params: movie_data
      }.must_change "Movie.count", +1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      new_movie = Movie.find(body["id"].to_i)

      expect(new_movie.title).must_equal movie_data[:title]

      must_respond_with :success
    end

    it "does not create a new movie provided invalid data" do
      movie_data[:title] = nil

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
