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

  describe "decrease_inventory" do
    it "decreases inventory by 1" do
      before_inventory = valid_movie.available_inventory

      valid_movie.decrease_inventory
      after_inventory = valid_movie.available_inventory

      expect(after_inventory).must_equal before_inventory - 1
    end

    it "doesn't decrease inventory if no movies are available" do
      empty_movie = movies(:savior)
      expect(empty_movie.available_inventory).must_equal 0

      empty_movie.decrease_inventory

      expect(empty_movie.available_inventory).must_equal 0
    end
  end
end
