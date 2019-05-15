# frozen_string_literal: true

require 'test_helper'

describe MoviesController do
  describe 'index' do
    it 'should get index' do
      get movies_path
      value(response).must_be :success?
    end

    it 'should get the correct path with query title' do
      assert_recognizes({ controller: 'movies', action: 'index', sort: 'title' }, '/movies', sort: 'title')

      get movies_path, params: { sort: 'title' }
      must_respond_with :ok
    end

    it 'should get the correct path with query :p' do
      assert_recognizes({ controller: 'movies', action: 'index', p: 2 }, '/movies', p: 2)

      get movies_path, params: { p: 2 }
      must_respond_with :ok
    end

    it 'should get the correct path with query :n' do
      assert_recognizes({ controller: 'movies', action: 'index', n: 2 }, '/movies', n: 2)

      get movies_path, params: { n: 2 }
      must_respond_with :ok
    end

    it 'renders an error if any query params are invalid' do
      get movies_path, params: { sort: 'cheese' }

      body = JSON.parse(response.body)

      must_respond_with :not_found
      expect(body['message']).must_equal 'Query params not valid'
    end
  end

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
      { movie: {
        title: 'The Little Mermaid',
        overview: 'A woman gives up her ability to talk for a man.',
        release_date: '1989-08-15',
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

    it 'returns an error for invalid movie data' do
      movie_data[:movie][:title] = nil

      expect do
        post movies_path, params: movie_data
      end.wont_change 'Movie.count'
    end
  end
end
