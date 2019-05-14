require "test_helper"

describe Movie do
  describe "validations" do
    let(:movie) { 
      Movie.create(
        title: "new movie",
        overview: "it's a movie",
        release_date: "2000-01-01",
        inventory: 10
      )
    }

    it "passes validations with good data" do
      expect(movie).must_be :valid?
    end

    it "rejects a movie without a title" do
      movie.title = ""
      movie.save
      result = movie.valid?

      expect(result).must_equal false
      expect(movie.errors.messages).must_include :title
    end

    it "rejects a movie without an overview" do
      movie.overview = ""
      movie.save
      result = movie.valid?

      expect(result).must_equal false
      expect(movie.errors.messages).must_include :overview
    end

    it "rejects a movie without a release date" do
      movie.release_date = ""
      movie.save
      result = movie.valid?

      expect(result).must_equal false
      expect(movie.errors.messages).must_include :release_date
    end

    it "rejects a movie without inventory" do
      movie.inventory = ""
      movie.save
      result = movie.valid?

      expect(result).must_equal false
      expect(movie.errors.messages).must_include :inventory
    end
  end
end
