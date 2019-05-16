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
    it "sorts by name when given sort title query params" do
      get "/movies?sort=title"

      body = JSON.parse(response.body)
      body.first["title"].must_equal "Good Will Hunting"
    end

    it "sorts by id when not given sort query params" do
      Movie.destroy_all
      movie1 = Movie.create(title: "Test 1", inventory: 1)
      movie1.id = 1
      movie1.save
      movie2 = Movie.create(title: "Test 2", inventory: 2)
      movie2.id = 2
      movie2.save

      get "/movies"

      body = JSON.parse(response.body)
      expect(body.first["title"]).must_equal "Test 1"
      expect(body.first["id"]).must_equal 1
    end

    it "paginates the movie index" do
      Movie.destroy_all
      movie1 = Movie.create(title: "Test 1", inventory: 1)
      movie1.id = 1
      movie1.save
      movie2 = Movie.create(title: "Test 2", inventory: 1)
      movie2.id = 2
      movie2.save

      get "/movies?n=1&p=2"

      body = JSON.parse(response.body)
      expect(body.first["title"]).must_equal "Test 2"
      expect(body.first["id"]).must_equal 2
    end

    it "paginates and sorts by title" do

      get "/movies?sort=title&n=1&p=2"

      body = JSON.parse(response.body)
      expect(body.first["title"]).must_equal "Revolutionary Road"
    end

    it "returns an empty array if page in query is beyond content pages" do
      get "/movies?n=1&p=4"

      body = JSON.parse(response.body)
      expect(body).must_equal []
      body.must_be_kind_of Array
    end

    it "sorts by id if given invalid sort param" do

      Movie.destroy_all
      movie1 = Movie.create(title: "Test 1", inventory: 1)
      movie1.id = 1
      movie1.save
      movie2 = Movie.create(title: "Test 2", inventory: 1)
      movie2.id = 2
      movie2.save

      get "/movies?sort=cat"

      body = JSON.parse(response.body)
      expect(body.first["title"]).must_equal "Test 1"
      expect(body.first["id"]).must_equal 1
    end
  end

  describe "show" do
    it "can get a movie" do
      get movie_path(movies(:movie_one).id)
      must_respond_with :success
    end

    it "responds with not found and errors hash if movie is not found" do
      get movie_path(-1)
      must_respond_with :not_found
      body = JSON.parse(response.body)
      body["ok"].must_equal false
      body["errors"].must_equal "Movie not found"
      expect(response.header["Content-Type"]).must_include "json"
    end

    it "still returns JSON if the request is bogus" do
      get movie_path("bogus")
      expect(response.header["Content-Type"]).must_include "json"
    end
  end

  describe "create" do
    let(:movie_data) {
      {
        title: "Titanic",
        overview: "Romantic & sad",
        release_date: 1997 - 12 - 19,
        inventory: 10,
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

    it "returns an error for invalid movie data" do
      movie_data["inventory"] = nil

      expect {
      post movies_path, params: { movie:movie_data }
    }.wont_change "Movie.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "inventory"
      must_respond_with :bad_request
    end
  end
end
