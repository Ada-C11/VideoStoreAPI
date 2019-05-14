require "test_helper"

describe MoviesController do
  describe "index" do
    before do
      get movies_path
    end
    it "will get a 200 ok response" do
      must_respond_with :ok
    end

    it "response will be json" do
      expect(response["Content-Type"]).must_include "json"
    end

    it "response will be a hash" do
      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Array
    end

    it "return all the movies" do
      body = JSON.parse(response.body)
      expect(body.length).must_equal Movie.count
    end

    it "returns pets with exactly the required fields" do
      req_fields = %w(id title release_date)
      body = JSON.parse(response.body)
      body.each do |movie|
        expect(movie.keys.sort).must_equal req_fields.sort
      end
    end
  end
end
