require "test_helper"

describe Rental do
  let(:rental) { rentals(:rental1) }
  let(:movie) { movies(:movie1) }

  it "must be valid" do
    expect(rental.valid?).must_equal true
  end

  describe "relations" do
    it "belongs to a movie" do
      rental.movie = movie

      expect(rental.movie_id).must_equal movie.id
    end

    it "can set the movie through the movie_id" do
      rental.movie_id = movie.id

      expect(rental.movie).must_equal movie
    end
  end
end
