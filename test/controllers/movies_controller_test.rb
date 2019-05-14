require "test_helper"

describe MoviesController do
  describe "show" do
    it "can get a movie by id" do
      movie = movies.first
      get movie_path(movie.id)
      must_respond_with :success
    end

    it "will respond with not found of given an invalid movie id" do
      fake_id = -1
      get movie_path(fake_id)

      must_respond_with :not_found
    end
  end
end
