require "test_helper"

describe RentalsController do
  let(:customer) { customers(:jessica) }
  let(:movie) { movies(:harrypotter) }
  let(:rental_data) {
    {
      customer_id: customer.id,
      movie_id: movie.id,
    }
  }

  describe "check_out" do 
    it "creates an instance of Rental" do 
      expect {
        post check_out_path, params: rental_data
      }.must_change "Rental.count", 1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"      
    end
  end
      # it "creates a new movie given valid data" do
      #   expect {
      #     post movies_path, params: movie_data
      #   }.must_change "Movie.count", 1
  
      #   body = JSON.parse(response.body)
      #   expect(body).must_be_kind_of Hash
      #   expect(body).must_include "id"
  
      #   movie = Movie.find(body["id"].to_i)
  
      #   expect(movie.title).must_equal movie_data[:title]
      #   expect(movie.overview).must_equal movie_data[:overview]
      #   expect(movie.release_date).must_equal Date.parse(movie_data[:release_date])
      #   expect(movie.inventory).must_equal movie_data[:inventory]
  
      #   must_respond_with :success
      # end
    # it "returns an error if no params" do
    #   expect {
    #     post movies_path
    #   }.wont_change "Movie.count"

    #   body = JSON.parse(response.body)

    #   expect(body).must_be_kind_of Hash
    #   expect(body).must_include "errors"
    #   must_respond_with :bad_request
    # end


    # it "returns an error if no title" do
    #   movie_data["title"] = nil

    #   expect {
    #     post movies_path, params: movie_data
    #   }.wont_change "Movie.count"

    #   body = JSON.parse(response.body)

    #   expect(body).must_be_kind_of Hash
    #   expect(body).must_include "errors"
    #   expect(body["errors"]).must_include "title"
    #   must_respond_with :bad_request
    # end

    # it "creates a new movie if no overview" do
    #   movie_data["overview"] = nil

    #   expect {
    #     post movies_path, params: movie_data
    #   }.must_change "Movie.count", 1

    #   body = JSON.parse(response.body)
    #   expect(body).must_be_kind_of Hash
    #   expect(body).must_include "id"

    #   movie = Movie.find(body["id"].to_i)

    #   expect(movie.title).must_equal movie_data[:title]
    #   must_respond_with :success
    # end

    # it "returns an error if no release date" do
    #   movie_data["release_date"] = nil

    #   expect {
    #     post movies_path, params: movie_data
    #   }.wont_change "Movie.count"

    #   body = JSON.parse(response.body)

    #   expect(body).must_be_kind_of Hash
    #   expect(body).must_include "errors"
    #   expect(body["errors"]).must_include "release_date"
    #   must_respond_with :bad_request
    # end

    # it "returns an error if no inventory" do
    #   movie_data["inventory"] = nil

    #   expect {
    #     post movies_path, params: movie_data
    #   }.wont_change "Movie.count"

    #   body = JSON.parse(response.body)

    #   expect(body).must_be_kind_of Hash
    #   expect(body).must_include "errors"
    #   expect(body["errors"]).must_include "inventory"
    #   must_respond_with :bad_request
    # end
end
