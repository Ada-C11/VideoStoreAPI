require "test_helper"

describe Movie do
  let(:movie) { movies(:movie_1) }

  it "must be valid given complete validations" do
    expect(movie.valid?).must_be true
  end

  describe "validations" do
    it "will not be valid if missing title" do
      # movie.title = nil
      expect(movie.valid?).must_be false
    end

    it "will not be valid if missing overview" do
    end

    it "will not be valid if missing release_date" do
    end

    it "will not be valid if missing inventory" do
    end
  end
end

# has_many :rentals
# has_many :customers, through: :rentals

# validates :title, presence: true
# validates :overview, presence: true
# validates :release_date, presence: true
# validates :inventory, presence: true
