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
      keys = %w(id release_date title)
      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end
  end

  describe "show" do
    it "can get a movie" do
      get movie_path(movies(:two).id)
      must_respond_with :success
    end

    it "returns JSON with bogus data" do
      get movie_path(-1)
      expect(response.header["Content-Type"]).must_include "json"
    end

    # success case: retrieves json for missing field
    it "returns all keys, even with empty non-required field" do
      movie = Movie.create!(title: "Sparrow",
                            release_date: "2019-05-14",
                            inventory: 7)

      get movie_path(movie)

      must_respond_with :success

      body = JSON.parse(response.body)
      expect(body["overview"]).must_be_nil

      keys = %w(available_inventory inventory overview release_date title)
      body.keys.sort.must_equal keys
    end

    # failure case, responds with 404
    it 'responds with 404 for movie not found' do
      id = -1
      get movie_path(id)
      must_respond_with :not_found
    end 

  end

  describe "create" do
    before do 
      @movie_data =
        {
          title: "Jack",
          overview: "Captain Barbossa",
          release_date: "2019-05-14",
          inventory: 7,
        }
    end 

    it "creates a new movie given valid data" do
      expect {
        post movies_path, params: @movie_data
      }.must_change "Movie.count", +1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash

      movie = Movie.find_by(title: "Jack")

      expect(movie.title).must_equal @movie_data[:title]
      expect(movie.overview).must_equal @movie_data[:overview]
      expect(movie.release_date).must_be_kind_of Date
      expect(movie.inventory).must_equal @movie_data[:inventory]

      must_respond_with :success
    end

    it 'creates data with empty non-required fields' do
      movie_data = {
        title: "Jack",
        inventory: 7,
      }

      expect {
        post movies_path, params: movie_data
      }.must_change "Movie.count", 1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash

      movie = Movie.find_by(title: "Jack")

      expect(movie.title).must_equal movie_data[:title]
      expect(movie.inventory).must_equal movie_data[:inventory]
      must_respond_with :success
    end 

    it "returns an error for invalid movie data" do
      @movie_data["title"] = nil

      expect {
        post movies_path, params: @movie_data 
      }.wont_change "Movie.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "title"
      must_respond_with :bad_request
    end
  end
end
