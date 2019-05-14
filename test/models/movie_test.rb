require "test_helper"

describe Movie do
  let(:movie) { movies(:test) }

  it "must be valid" do
    expect(movie.valid?).must_equal true
  end

  it "wont be valid without a title" do
    movie.title = ""
    expect(movie.valid?).must_equal false
  end

  it "wont be valid without inventory" do
    movie.inventory = ""
    expect(movie.valid?).must_equal false
  end

  it "canhaz an associated customer" do
    expect(movie).must_respond_to :customers
    expect(movie.customers).must_include customers(:shelley)
  end

  it "can have an associated rental" do
    expect(movie).must_respond_to :rentals
    expect(movie.rentals).must_include rentals(:one)
  end
end
