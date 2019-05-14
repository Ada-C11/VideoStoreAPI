require "test_helper"

describe Movie do
  let(:good_data) {
    {
      title: "Mulan",
      overview: "Lady and a mini dragon go off to war",
      release_date: "1993-12-27",
      inventory: 10,
    }
  }

  # let(:movie) { Movie.new }

  # it "must be valid" do
  #   value(movie).must_be :valid?
  # end
  describe "Validations" do
    it "is valid with good data" do
      movie = Movie.new(good_data)

      result = movie.valid?
      expect(result).must_equal true
    end

    it "isnt valid without a title " do
      good_data[:title] = nil
      movie = Movie.new(good_data)

      result = movie.valid?
      expect(result).must_equal false
    end

    it "isnt valid without an inventory" do
      good_data[:inventory] = nil
      movie = Movie.new(good_data)

      result = movie.valid?
      expect(result).must_equal false
    end
  end
end
