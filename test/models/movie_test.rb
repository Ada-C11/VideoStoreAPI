require "test_helper"

describe Movie do
  let(:movie) { movies(:one) }

  it "must be valid" do
    value(movie).must_be :valid?
  end

  it "requires a title" do
    
    movie[:title] = nil

    expect(movie.valid?).must_equal false

    movie.reload
  end
end
