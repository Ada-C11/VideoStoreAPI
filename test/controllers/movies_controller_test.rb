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
      movie_fields = ["id", "release_date", "title", "overview", "inventory"]

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
end
