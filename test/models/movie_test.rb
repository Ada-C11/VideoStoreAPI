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
    describe "increase_inventory" do
      it "increases a movies inventory count by one given a valid movie" do
        inventory = movie.inventory

        movie.increase_inventory
        movie.reload

        expect(movie.inventory).must_equal inventory + 1
      end

      it "will return false and error messages given an invalid movie" do
        movie = Movie.create

        expect(movie.increase_inventory).must_equal false
        expect(movie.errors.messages).must_include :inventory
        expect(movie.errors.messages[:inventory]).must_equal ["can't be blank", "is not a number"]
      end
    end
  end
end
