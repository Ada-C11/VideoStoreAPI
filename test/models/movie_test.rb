require "test_helper"

describe Movie do
  let(:movie) { movies(:one) }

  it "must be valid" do
    value(movie).must_be :valid?
  end
  
  it "requires title, and inventory" do
    required_fields = [:title, :overview, :release_date, :inventory]

    required_fields.each do |field|
       movie[field] = nil

       expect(movie.valid?).must_equal false

       movie.reload
    end
  end

  it "requires a numeric inventory" do
    movie.inventory = "five"

    expect(movie.valid?).must_equal false
  end
end
