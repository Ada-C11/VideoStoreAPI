require "test_helper"

describe Movie do
  let(:movie) { movies(:movie2) }
  let(:customer) { customers(:customer2) }
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

  describe "validations" do
    it "must have a title" do
      movie.title = nil

      expect(movie.valid?).must_equal false
      expect(movie.errors.messages).must_include :title
      expect(movie.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "must have an inventory value" do
      movie.inventory = nil

      expect(movie.valid?).must_equal false
      expect(movie.errors.messages).must_include :inventory
      expect(movie.errors.messages[:inventory]).must_include "can't be blank"
    end

    it "iventory amount must be an integer" do
      movie.inventory = "cat"

      expect(movie.valid?).must_equal false
      expect(movie.errors.messages).must_include :inventory
      expect(movie.errors.messages[:inventory]).must_equal ["is not a number"]
    end

    it "must have an inventory amount greater than -1" do
      inventory = [0, 1, 10, 100, 4000]
      inventory.each do |amount|
        movie.inventory = amount
        expect(movie.valid?).must_equal true
      end

      inventory = [-1, -5, -10, -100]
      inventory.each do |amount|
        movie.inventory = amount

        expect(movie.valid?).must_equal false
        expect(movie.errors.messages).must_include :inventory
        expect(movie.errors.messages[:inventory]).must_equal ["must be greater than -1"]
      end
    end
  end

  describe "custom methods" do
    describe "available_inventory" do
      it "returns the available inventory for a movie" do
        rental_params = {
          customer_id: customers(:customer1).id,
          movie_id: movies(:movie1).id,
        }

        available = movie.available_inventory
        inventory = movie.inventory

        expect(inventory).must_equal 2
        expect(available).must_equal 1
      end
    end
  end
end
