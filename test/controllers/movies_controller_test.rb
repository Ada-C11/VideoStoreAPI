require "test_helper"

describe MoviesController do
  describe 'index' do
    it 'succeeds when there are movies' do
      get movies_path

      must_respond_with :success
    end

    it 'succeeds when there are no movies' do
      Movie.all do |movie|
        movie.destroy
      end

      get movies_path

      must_respond_with :success
    end
  end

  describe 'show' do
    it "returns a 404 status code if the movie doesn't exist" do
      invalid_movie_id = 2947927

      get movie_path(invalid_movie_id)

      must_respond_with :bad_request

    end

    it "works for a movie that exists" do
      get movie_path(movies(:pride).id)

      must_respond_with :success
    end
  end

  describe "create" do
    let(:movie_data) {
      { 
        title: 'harry potter',
        overview: "pridefull",
        release_date: '2015-03-12',
        inventory: 8
      }
    }

    it "be able to create a new movie given valid data" do
      expect {
        post movies_path, params: { movie: movie_data}
      }.must_change "Movie.count", 1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      movie = Movie.find(body["id"].to_i)

      expect(movie.title).must_equal movie_data[:title]
      must_respond_with :success

    end

    it "sends back bad_request if no title is sent" do
      movie_data["title"] = nil

      expect {
        post movies_path, params: { movie: movie_data}
      }.wont_change "Movie.count"

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_equal [{"title"=>["can't be blank"]}]
      must_respond_with :bad_request

    end
  end
end
