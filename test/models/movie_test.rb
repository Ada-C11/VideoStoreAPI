require "test_helper"

describe Movie do
  describe "relations" do
    it "has rentals" do
      movie = movies(:one)
      movie.must_respond_to :rentals
      movie.rentals.each do |rental|
      rental.must_be_kind_of Rental
      end
    end
  end
end
