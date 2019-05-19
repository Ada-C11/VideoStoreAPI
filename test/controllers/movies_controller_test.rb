require "test_helper"

describe MoviesController do
  it "should get index" do
    get movies_index_url
    value(response).must_be :successful?
  end

  describe "create" do
    let(:movie_data) {
      {
        title: "Friday",
        release_date: "1995-04-25",
        inventory: 5,
        overview: "Friends have fun on Friday.",
      }
    }
    it "should create a movie given valid data" do
      expect {
        post movies_path, params: {movie: movie_data}
      }.must_change "Movie.count", 1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      movie = Movie.find(body["id"].to_i)

      expect(movie.title).must_equal movie_data[:title]
      must_respond_with :success
    end

    it "should error if movie cannot be created" do
      movie_data["title"] = ""

      expect {
        post movies_path, params: {movie: movie_data}
      }.wont_change "Movie.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "title"
      must_respond_with :bad_request
    end
  end
end
