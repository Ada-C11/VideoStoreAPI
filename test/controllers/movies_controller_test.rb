require "test_helper"

describe MoviesController do
  describe "Index" do
    it "can show all movies" do
      get movies_path
      must_respond_with :ok
    end
    
    it "returns json" do
      get movies_path
      expect(response.header["Content-Type"]).must_include "json"
    end
    
    it "returns movies with exactly the required fields" do
      keys = %w(inventory overview release_date title )
      get movies_path
      
      body = JSON.parse(response.body)
      
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end
  end
  
  describe "Show" do
    it "can get a movie" do
      get movie_path(movies(:two))
      must_respond_with :ok
    end
    
    it "throws an error if a movie can't be found" do
      get movie_path(-1)
      
      must_respond_with :bad_request
    end
  end
  
  describe "Create" do
    it "can create a new movie" do
      movie_data = {
        movie: {
          title: "Rush Hour 2",
          overview: "best movie ever",
          release_date: Date.new(2001, 11, 2),
          inventory: 5,
        }
      }
      
      expect {
        post movies_path, params: movie_data
      }.must_change "Movie.count", + 1
      
      must_respond_with :success
    end
  end
  
end
