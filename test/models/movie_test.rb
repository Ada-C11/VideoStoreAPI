require "test_helper"

describe Movie do
  describe "validation tests" do
    let(:movie) { movies(:one) }

    it "must be valid" do
      value(movie).must_be :valid?
    end

    it "requires a title" do
      required_fields = [:title]
      movie[:title] = nil

      expect(movie.valid?).must_equal false

      movie.reload
    end

    it "has required fields" do
      fields = [:title, :overview, :release_date, :inventory]

      fields.each do |field|
        expect(movie).must_respond_to field
      end
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
