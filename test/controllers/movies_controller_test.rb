require "test_helper"

describe MoviesController do
  describe "index" do
    it "returns a list of movies" do
      get movies_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a movie" do
      get movie_path(movies(:aladdin).id)
      must_respond_with :success
    end

    it "gives an error if movie is not found" do
      get movie_path(-1)
      must_respond_with :not_found
    end
  end

  describe "create" do
    let(:movie_data) {
      {
        title: "New Movie",
        overview: "Super awesome movie.",
        release_data: 2019-05-14,
        inventory: 4,
      }
    }

    it "creates a new movie given valid data" do
      expect {
      post movies_path, params: movie_data 
    }.must_change "Movie.count", 1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      movie = Movie.find(body["id"].to_i)

      expect(movie.title).must_equal movie_data[:title]
      must_respond_with :success
    end

  end
end
