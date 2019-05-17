require "test_helper"

describe MoviesController do
  describe "index" do
    it "returns a list of movies" do
      get movies_path
      must_respond_with :success
    end

    it "returns all of the movies" do
      get movies_path
      body = JSON.parse(response.body)
      expect(body.length).must_equal Movie.count
    end

    it "returns JSON" do
      get movies_path
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :success
    end

    it "body returns an array" do
      get movies_path
      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Array
    end
    
    it "returns movies with exactly the required fields" do
      keys = %w(id release_date title)

      get movies_path

      body = JSON.parse(response.body)

      body.each do |movie|
        expect(movie.keys.sort).must_equal keys
        expect(movie.keys.length).must_equal keys.length
      end
    end

    # REVIST AFTER HANDLING FOREIGN KEY CONSTRAINT
    # it "returns an empty array when there are no movies" do
    #   Movie.destroy_all

    #   get movies_path

    #   body = JSON.parse(response.body)
    
    #   expect(body).must_equal []
    # end
  end

  describe "show" do
    it "returns a movie that is valid" do
      keys = %w(available_inventory inventory overview release_date title )
      get movie_path(movies(:aladdin).id)

      body = JSON.parse(response.body)
 
      expect(body).must_be_kind_of Hash
      expect(body.keys.sort).must_equal keys
      must_respond_with :success
    end

    it "gives an error if movie is not found" do
      get movie_path(-1)

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
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

    it "does not create movie with invalid parameters" do
      movie_data[:title] = nil

      expect {
        post movies_path, params: movie_data 
      }.wont_change "Movie.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "title"
      must_respond_with :bad_request
    end
  end
end
