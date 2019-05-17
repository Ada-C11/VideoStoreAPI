require "test_helper"

describe Movie do
  let(:good_data) {
    {
      title: "Mulan",
      overview: "Lady and a mini dragon go off to war",
      release_date: "1993-12-27",
      inventory: 10,
    }
  }

  let(:movie) { movies(:one) }
  let(:rental) { rentals(:one) }
  let(:customer) { customers(:one) }

  it "must be valid" do
    value(movie).must_be :valid?
  end

  describe "Validations" do
    it "isnt valid without a title " do
      good_data[:title] = nil
      movie = Movie.new(good_data)

      result = movie.valid?
      expect(result).must_equal false
    end

    it "isnt valid without an inventory" do
      good_data[:inventory] = nil
      movie = Movie.new(good_data)

      result = movie.valid?
      expect(result).must_equal false
    end

    it "requires inventory input to be integer" do
      good_data[:inventory] = "thirty"

      movie = Movie.new(good_data)

      movie.valid?.must_equal false
      movie.errors.messages.must_include :inventory
    end
  end

  describe "Relationship" do
    it "can have 0 rental" do
      movie = Movie.new(good_data)
      rentals = movie.rentals

      expect(rentals.length).must_equal 0
    end

    it "can have 1 or more rental by shoveling a rental into movie" do
      movie.rentals << rental

      expect(movie.rentals).must_include rental
    end
  end

  describe "Custom Method - checkout" do
    it "decreases movie's available inventory when checkout" do
      start_count = movie.available_inventory
      Movie.checkout_inventory(movie)

      expect(movie.available_inventory).must_equal start_count - 1
    end

    it "returns false if there is no available invenoty " do
      movie.available_inventory = 0
      expect(Movie.checkout_inventory(movie)).must_equal false
    end
  end

  describe "Custom Method - checkin" do
    it "increases movie's available inventory when checkin" do
      start_count = movie.available_inventory
      Movie.checkin_inventory(movie, customer)

      expect(movie.available_inventory).must_equal start_count + 1
    end

    it "returns false if there is no associated movie checked out" do
      movie.available_inventory = movie.inventory
      customer.movies_checked_out_count = 0
      expect(Movie.checkin_inventory(movie, customer)).must_equal false
    end
  end
end
