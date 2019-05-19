require "test_helper"

describe Movie do
  let(:movie) { movies(:one) }

  it "must be valid" do
    value(movie).must_be :valid?
  end

  describe "validations" do
    it "title is required" do
      movie.title = ""
      movie.save
      expect(movie.valid?).must_equal false
      movie.errors.messages.must_include :title
      movie.errors[:title].include?("can't be blank")
    end

    it "overview is required" do
      movie.overview = ""
      movie.save
      expect(movie.valid?).must_equal false
      movie.errors.messages.must_include :overview
      movie.errors[:overview].include?("can't be blank")
    end

    it "release_date is required" do
      movie.release_date = ""
      movie.save
      expect(movie.valid?).must_equal false
      movie.errors.messages.must_include :release_date
      movie.errors[:release_date].include?("can't be blank")
    end
  end
end
