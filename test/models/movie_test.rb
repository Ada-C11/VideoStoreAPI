require "test_helper"

describe Movie do
  let(:movie) { Movie.new(title: "Test Movie", overview: "This is a test movie", release_date: "2019-04-05", inventory: 5) }

  it "must be valid" do
    value(movie).must_be :valid?
  end
end
