require "test_helper"

describe Movie do
  let(:movie) { movies(:movie_1) }

  it "must be valid given complete validations" do
    expect(movie.valid?).must_equal true
  end

  describe "validations" do
    it "will not be valid if missing title" do
      movie.title = nil
      expect(movie.valid?).must_equal false
    end

    it "will not be valid if missing overview" do
      movie.overview = nil
      expect(movie.valid?).must_equal false
    end

    it "will not be valid if missing release_date" do
      movie.release_date = nil
      expect(movie.valid?).must_equal false
    end

    it "will not be valid if missing inventory" do
      movie.inventory = nil
      expect(movie.valid?).must_equal false
    end
  end

  describe "relationships" do
    describe "rentals, has_many" do
      it "can have 0 rentals" do
      end

      it "can have 1 or more rentals" do
      end
    end

    describe "customers, many/through"  do 
      it "can have 0 customers" do
      end

      it "can have 1 or more customers" do
      end
    end
  end
end

# has_many :rentals
# has_many :customers, through: :rentals

# validates :title, presence: true
# validates :overview, presence: true
# validates :release_date, presence: true
# validates :inventory, presence: true
