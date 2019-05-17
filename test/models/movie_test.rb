require "test_helper"

describe Movie do
  let (:movie) {
    movies(:harrypotter)
  }

  describe "validations" do
    it "is valid when all fields are present" do
      result = movie.valid?

      expect(result).must_equal true
    end

    it "requires a title" do
      movie.title = nil

      valid_movie = movie.valid?

      expect(valid_movie).must_equal false
      expect(movie.errors.messages).must_include :title
      expect(movie.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "requires a release date" do
      movie.release_date = nil

      valid_movie = movie.valid?

      expect(valid_movie).must_equal false
      expect(movie.errors.messages).must_include :release_date
      expect(movie.errors.messages[:release_date]).must_equal ["can't be blank"]
    end

    it "requires an inventory" do
      movie.inventory = nil

      valid_movie = movie.valid?

      expect(valid_movie).must_equal false
      expect(movie.errors.messages).must_include :inventory
      expect(movie.errors.messages[:inventory]).must_equal ["can't be blank"]
    end
  end

  describe "relations" do
    it "has many rentals" do
      movie.must_respond_to :rentals
      movie.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end
  end

  # describe "custom methods" do
  # end
end
