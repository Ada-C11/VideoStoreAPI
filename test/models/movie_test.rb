require "test_helper"

describe Movie do
  describe "relations" do
    it "has rentals" do
      movie = movies(:movie_one)
      movie.must_respond_to :rentals
      movie.rentals.each do |rental|
      rental.must_be_kind_of Rental
      end
    end
  end

  describe "validations" do
    it "requires inventory" do
      movie = Movie.new(title: "The Departed")
      movie.valid?.must_equal false
      movie.errors.messages.must_include :inventory
    end

    it "requires inventory to be an integer" do
      movie = Movie.new(inventory: "five")
      movie.valid?.must_equal false
      movie.errors.messages.must_include :inventory
    end

    it "accepts valid a new movie including an inventory" do
      movie = Movie.new(inventory: 5)
      movie.valid?.must_equal true
    end
  end
end
