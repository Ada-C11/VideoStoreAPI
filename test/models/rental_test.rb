require "test_helper"

describe Rental do
  let(:rental) { rentals(:rental1) }
  let(:movie) { movies(:movie1) }

  it "must be valid" do
    expect(rental.valid?).must_equal true
  end

  describe "relations" do
    it "belongs to a movie" do
      rental.movie = movie

      expect(rental.movie_id).must_equal movie.id
    end

    it "can set the movie through the movie_id" do
      rental.movie_id = movie.id

      expect(rental.movie).must_equal movie
    end
  end

  describe "custom methods" do
    describe "set_check_in" do
      it "must set the check_in_date" do
        orig_check_in = rental.check_in_date

        rental.set_check_in
        rental.reload

        assert_nil(orig_check_in)
        expect(rental.check_in_date).must_equal Date.current
      end

      it "will return false and error messages given an invalid rental" do
        rental = Rental.create

        expect(rental.set_check_in).must_equal false
        expect(rental.errors.messages).must_include :movie
        expect(rental.errors.messages).must_include :customer
        expect(rental.errors.messages[:movie]).must_equal ["must exist"]
        expect(rental.errors.messages[:customer]).must_equal ["must exist"]
      end
    end
  end
end
