# frozen_string_literal: true

require 'test_helper'

describe MoviesController do
<<<<<<< HEAD
  describe "index" do
    it "should get index" do
      get movies_path
      value(response).must_be :successful?
    end
=======
  it 'should get index' do
    get movies_path
    value(response).must_be :success?
>>>>>>> 4066d05521e6d052329a5565f470625aab8f4142
  end
  describe "show" do
    it "should get show" do
      get movie_path(Movie.first)
      value(response).must_be :successful?
    end

<<<<<<< HEAD
    it "renders an error if ID is invalid" do
      get movie_path(Movie.last.id + 1)
      must_respond_with :not_found

      error = JSON.parse(response.body)
      expect(error["errors"]).must_be_kind_of Array
    end
  end

  describe "create" do
    it "should get create" do
      post movies_path
      value(response).must_be :successful?
=======
  describe 'show' do
    it 'should get show' do
      get movies_path(movies(:one))
      value(response).must_be :success?
    end

    it 'will display error if movie not found' do
      get movie_path(-1)
      body = JSON.parse(response.body)
      must_respond_with :not_found
      expect(body['message']).must_equal 'Movie not found'
    end
  end

  describe 'create' do
    let(:movie_data) do
      { movie:
        {
          title: 'The Little Mermaid',
          overview: 'A woman gives up her ability to talk for a man.',
          release_date: 1989,
          inventory: 15
        } }
    end

    it 'creates a new movie given valid data' do
      expect do
        post movies_path, params: movie_data
      end.must_change 'Movie.count', 1
      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include 'id'
      value(response).must_be :success?
    end

    it "returns an error for invalid movie data" do
      
>>>>>>> 4066d05521e6d052329a5565f470625aab8f4142
    end
  end
end
