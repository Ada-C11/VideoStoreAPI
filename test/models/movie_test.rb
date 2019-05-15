require "test_helper"

class MovieTest < ActiveSupport::TestCase
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
    expect(movie.rentals.count).must_equal 2
  end

  it "returns available inventory" do
    expect(movie.available_inventory).must_equal 9
  end

  it "returns 0 when there are no available inventory" do
    movie.inventory = 0
    expect(movie.available_inventory).must_equal 0
  end
end
