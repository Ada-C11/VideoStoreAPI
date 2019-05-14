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

    it "returns all of the movies" do
      get movies_path

      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns movies with exactly the required fields" do
      keys = %w(id title release_date)
      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.must_equal keys
      end
    end
  end

  # # this is from ada pets -- might not work at all lol
  # describe "show" do
  #   # This bit is up to you!
  #   it "can get a pet" do
  #     get pet_path(pets(:two).id)
  #     must_respond_with :success
  #   end

  #   it "responds with error code and message if not found" do
  #     invalid_id = -1
  #     get pet_path(invalid_id)
  #     must_respond_with :not_found
  #     body = JSON.parse(response.body)
  #     body.keys.first.must_equal "error"
  #     expect(body["error"]).must_equal "This pet doesn't exist :("
  #   end
  # end
end
