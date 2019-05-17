# frozen_string_literal: true

require 'test_helper'

describe Movie do
  let(:movie) { Movie.new(title: 'Test Movie', overview: 'This is a test movie', release_date: '2019-04-05', inventory: 5) }

  it 'must be valid' do
    value(movie).must_be :valid?
  end

  describe 'validations' do
    it 'must have a title' do
      movie.title = nil
      movie.save
      expect(movie.valid?).must_equal false
      expect(movie.errors).must_include 'title'
    end

    it 'must have an overview' do
      movie.overview = nil
      movie.save
      expect(movie.valid?).must_equal false
      expect(movie.errors).must_include 'overview'
    end

    it 'must have a release date' do
      movie.release_date = nil
      movie.save
      expect(movie.valid?).must_equal false
      expect(movie.errors).must_include 'release_date'
    end

    it 'inventory must be a number' do
      movie.inventory = 'abcd'
      movie.save
      expect(movie.valid?).must_equal false
      expect(movie.errors[:inventory].first).must_include 'is not a number'
    end
  end

  describe 'relationships' do
    it 'has many rentals' do
      movie.save
      expect(movie).must_respond_to :rentals
    end
  end
end
