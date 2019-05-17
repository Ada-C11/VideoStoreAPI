require "test_helper"

describe Movie do
  before do
    @movie = Movie.new(title: "test movie", inventory: 5)
  end

  describe "validations" do
    it "is valid when all fields are present" do
      result = @movie.valid?

      expect(result).must_equal true
    end

    it "is valid when title is present" do
      expect(@movie.title).wont_be_nil
      result = @movie.valid?

      expect(result).must_equal true
    end

    it "is valid when inventory is present" do
      expect(@movie.inventory).wont_be_nil
      result = @movie.valid?

      expect(result).must_equal true
    end

    it "is invalid without a title" do
      @movie.title = nil

      result = @movie.valid?

      expect(result).must_equal false
    end

    it "is invalid without an inventory" do
      @movie.inventory = nil

      result = @movie.valid?

      expect(result).must_equal false
    end
  end

  describe "relations" do
    it "can add a rental through .rentals" do
      rental = Rental.new()
      @movie.rentals << rental
      expect(@movie.rentals).must_include rental
    end

    it "returns empty array if no rentals" do
      expect(@movie.rentals).must_equal []
    end
  end
end
