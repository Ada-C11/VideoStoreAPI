require "test_helper"

describe Movie do
  describe "custom methods" do
    let(:movie) { Movie.first }
    it "will return a value for movies_checked out" do
      expect(movie.available_inventory).must_equal movie.inventory
    end
  end
end
