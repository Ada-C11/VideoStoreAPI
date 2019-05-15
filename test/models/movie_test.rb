require "test_helper"

class PetTest < ActiveSupport::TestCase
  let(:movie) { movies(:one)}

  it "can be created" do
    value(movie.valid?).must_equal true
  end

  it "requires title, overview, inventory, release date" do 
    required_fields = [:title, :overview, :inventory, :release_date]

    required_fields.each do |field|
      movie[field] = nil

      expect(movie.valid?).must_equal false

      movie.reload
    end
  end

  it "returns all the rentals" do
    movie.rentals
    expect(movie.rentals.count).must_equal 1
  end
end
