require "test_helper"

describe MoviesController do
  describe "show" do
    it "can show data for a movie that exists" do
      get movie_path(Movie.first.id)
      must_respond_with :success
    end

    it "returns 404 for a movie that doesn't exist" do
      get movie_path(-1)
      must_respond_with :error
    end
  end
end
