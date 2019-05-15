require "test_helper"

describe MoviesController do
  describe "index" do
    it "can render without crashing" do
      get movies_path

      must_respond_with :ok
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

    it "returns all of the customers" do
      get movies_path

      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns customers with exactly the required fields" do
      keys = %w(available_inventory id inventory overview release_date title)
      get movies_path
      body = JSON.parse(response.body)
      body.each do |movies|
        movies.keys.sort.must_equal keys
      end
    end
  end

  # it "should get zomg" do
  #   get movies_zomg_url
  #   value(response).must_be :success?
  # end

end
