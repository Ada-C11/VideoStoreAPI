require "test_helper"

describe Movie do
  let(:movie) { Movie.new(title: "Stardust") }

  describe "validations" do
    it "must be valid" do
      value(movie).must_be :valid?
    end

    it "returns false for invalid movie data" do
      movie = Movie.new
      movie.valid?.must_equal false
    end
  end

  describe "relations" do
    it "has_many rentals" do
      movie = movies(:GreenMile)
      movie.rentals.count.must_equal 1
    end
  end
end
