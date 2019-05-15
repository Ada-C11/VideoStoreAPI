require "test_helper"

describe Movie do
  let(:movie) { movies(:movie2) }
  let(:rental1) { rentals(:rental1) }
  let(:rental2) { rentals(:rental2) }

  it "must be valid" do
    expect(movie.valid?).must_equal true
  end

  describe "relations" do
    it "can have zero rentals" do
      rentals = movie.rentals
      expect(rentals.length).must_equal 0
    end

    it "can have many rentals" do
      rentals = movie.rentals
      rentals.push(rental1, rental2)

      expect(rentals.length).must_equal 2
      expect(rentals).must_include rental1
      expect(rentals).must_include rental2
    end
  end

  describe "custom methods" do
  end
end
