require "test_helper"

describe Movie do
  let(:movie) { Movie.new }
  let(:valid_movie) { movies(:blacksmith) }

  it "must be valid" do
    expect(valid_movie.valid?).must_equal true
  end

  it "requires a title" do
    expect(movie.valid?).must_equal false
  end
end
