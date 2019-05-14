require "test_helper"

describe MoviesController do
  describe "index" do
    it "should get index" do
      get movies_path
      value(response).must_be :successful?
    end
  end
  describe "show" do
    it "should get show" do
      get movie_path(Movie.first)
      value(response).must_be :successful?
    end

    it "renders an error if ID is invalid" do
      get movie_path(Movie.last.id + 1)
      must_respond_with :not_found

      error = JSON.parse(response.body)
      expect(error["errors"]).must_be_kind_of Array
    end
  end

  describe "create" do
    it "should get create" do
      post movies_path
      value(response).must_be :successful?
    end
  end
end
