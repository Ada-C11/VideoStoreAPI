require "test_helper"

describe MoviesController do
  describe "show" do
    it "can get a movie by id" do
      movie = movies.first
      get movie_path(movie.id)
      must_respond_with :success
    end
  end
end
