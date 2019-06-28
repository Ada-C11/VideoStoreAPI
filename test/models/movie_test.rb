require "test_helper"

describe Movie do
  let(:movie) { movies(:wild) }
  describe "validations" do
    it "is a valid movie" do
      this_movie = movie.valid?
      expect(this_movie).must_equal true
    end

    it "requires a title" do
      movie.title = nil

      valid_movie = movie.valid?

      expect(valid_movie).must_equal false
      expect(movie.errors.messages).must_include :title
      expect(movie.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "requires an overview" do
      movie.overview = nil

      valid_movie = movie.valid?

      expect(valid_movie).must_equal false
      expect(movie.errors.messages).must_include :overview
      expect(movie.errors.messages[:overview]).must_equal ["can't be blank"]
    end

    it "requires a release date" do
      movie.release_date = nil

      valid_movie = movie.valid?

      expect(valid_movie).must_equal false
      expect(movie.errors.messages).must_include :release_date
      expect(movie.errors.messages[:release_date]).must_equal ["can't be blank"]
    end

    it "requires inventory" do
      movie.inventory = nil

      valid_movie = movie.valid?

      expect(valid_movie).must_equal false
      expect(movie.errors.messages).must_include :inventory
      expect(movie.errors.messages[:inventory]).must_equal ["can't be blank"]
    end
  end

  describe "relationship" do
    it "can have many rentals" do
      movie.must_respond_to :rentals
      movie.rentals.each do |item|
        item.must_be_kind_of Rental
      end
    end
  end

  describe "available_inventory" do
    it "can calculate available_inventory for movie" do
      movie = movies(:will)
      avail_inv = movie.available_inventory

      expect(avail_inv).must_equal 3
    end

    it "can calculate available_inventory for movie that has not been rented" do
      movie = movies(:stranger)
      avail_inv = movie.available_inventory

      expect(avail_inv).must_equal movie.inventory
    end
  end
end
