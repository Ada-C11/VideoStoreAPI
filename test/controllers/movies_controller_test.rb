require "test_helper"

describe MoviesController do
  let(:movie_data) {
    {
      title: "Mulan",
      overview: "Lady and a mini dragon go off to war",
      release_date: "1993-12-27",
      inventory: 10,
    }
  }
  describe "show" do
    it "can get a movie by id" do
      movie = movies.first
      get movie_path(movie.id)

      body = JSON.parse(response.body)
      expect(body).must_include "title"
      expect(body["title"]).must_equal movie.title
      must_respond_with :success
    end

    it "will respond with not found of given an invalid movie id" do
      fake_id = -1
      get movie_path(fake_id)

      must_respond_with :not_found
    end
  end

  describe "create" do
    it "creates a movie with good data" do
      expect {
        post movies_path, params: { movie: movie_data }
      }.must_change "Movie.count", 1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      movie = Movie.find(body["id"].to_i)

      expect(movie.title).must_equal movie_data[:title]
      must_respond_with :success
    end
    # it "returns an error if given bad movie data" do
    #   movie_data["title"] = nil

    #   expect {
    #     post movies_path, params: { movie: movie_data }
    #   }.wont_change "Movie.count"

    #   body = JSON.parse(response.body)

    #   expect(body).must_be_kind_of Hash
    #   expect(body).must_include "errors"
    #   expect(body["errors"]).must_include "title"
    #   must_respond_with :bad_request
    # end
  end
end
