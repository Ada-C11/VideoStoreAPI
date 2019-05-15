require "test_helper"

describe Movie do
  let(:movie) { Movie.new(title: "Stardust") }

  it "must be valid" do
    value(movie).must_be :valid?
  end

  it "returns false for invalid movie data" do
    movie = Movie.new
    movie.valid?.must_equal false
  end
end
