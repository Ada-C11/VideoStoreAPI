require "test_helper"

describe Movie do
  describe "validation tests" do
    let(:movie) { movies(:one) }

    it "must be valid" do
      value(movie).must_be :valid?
    end

    it "has all required fields" do
      fields = [:title, :overview, :release_date, :inventory, :available_inventory]

      fields.each do |field|
        expect(movie).must_respond_to field
      end
    end

    it "requires a title" do
      required_fields = [:title]
      movie[:title] = nil

      expect(movie.valid?).must_equal false

      movie.reload
    end

    it "requires an overview" do
      movie.overview = nil
      valid = movie.save

      expect(valid).must_equal false
      expect(movie.errors.messages).must_include :overview
    end

    it "requires a release date" do
      movie.release_date = nil
      valid = movie.save

      expect(valid).must_equal false
      expect(movie.errors.messages).must_include :release_date
    end

    it "requires an integer for inventory" do
      movie.inventory = "two"
      valid = movie.save

      expect(valid).must_equal false
      expect(movie.errors.messages).must_include :inventory
    end

    it "requires an integer that is greater than 0 for inventory" do
      movie.inventory = -1
      valid = movie.save

      expect(valid).must_equal false
      expect(movie.errors.messages).must_include :inventory
    end

    it "requires an integer for available_inventory" do
      movie.available_inventory = "two"
      valid = movie.save

      expect(valid).must_equal false
      expect(movie.errors.messages).must_include :available_inventory
    end

    it "requires an integer that is greater than 0 for available_inventory" do
      movie.available_inventory = -1
      valid = movie.save

      expect(valid).must_equal false
      expect(movie.errors.messages).must_include :available_inventory
    end
  end

  describe "available_inventory" do
    it "can calculate available_inventory for movie with rentals" do
      movie = movies(:one)
      num_available = movie.available_inventory

      expect(num_available).must_equal 4
    end

    it "can calculate available_inventory for movie with no rentals" do
      movie = movies(:three)
      num_available = movie.available_inventory

      expect(num_available).must_equal movie.inventory
    end
  end
end
