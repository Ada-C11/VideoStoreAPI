require "test_helper"

describe Movie do
  let(:movie) { Movie.new }

  describe "validations and instantiation" do
    it "won't be valid without title and inventory" do
      expect(movie).wont_be :valid?

      # for title
      expect(movie.errors.messages).must_include :title
      expect(movie.errors.messages[:title]).must_equal ["can't be blank"]

      # for inventory
      expect(movie.errors.messages).must_include :inventory
      expect(movie.errors.messages[:inventory]).must_equal ["can't be blank"]
    end

    it "will be valid with title and inventory and available inventory" do
      movie.update_attributes({ title: "Test movie", inventory: 5, available_inventory: 5 })
      
      expect(movie).must_be :valid?
      expect(movie.errors.messages).must_be_empty
    end

    it "responds to its fields" do
      ["title", "overview", "release_date", "inventory"].each do |field|
        expect(movie).must_respond_to field
      end
    end
  end

  describe "relationships" do
    it "" do
    end
  end

  describe "custom methods" do
    describe "checkin" do
      let(:movie) { movies(:movie_two) }
      let(:movie1) { movies (:movie_one) }

      it "will increase the available inventory when a movie is checked in" do
        amount = movie.available_inventory
        movie.increase_available_inventory

        movie.reload

        new_amount = movie.available_inventory

        expect(new_amount).must_equal amount + 1
      end

      it "will not increase the available inventory when the movie is not currently checked out" do
        amount = movie1.available_inventory
        movie1.increase_available_inventory

        movie1.reload

        new_amount = movie1.available_inventory

        expect(new_amount).must_equal amount
      end
    end

    describe "reduce avail inventory" do 
      let(:karate_movie) { movies(:movie_one) }

      it "when a movie is checked out will reduce available_inventory by 1" do 
        current_count = karate_movie.available_inventory

        karate_movie.reduce_avail_inventory
        karate_movie.reload
        expect(karate_movie.available_inventory).must_equal current_count - 1
      end

      it "returns false if no available inventory to checkout" do 
        10.times do 
          karate_movie.reduce_avail_inventory
        end
        current_count = karate_movie.available_inventory
        expect(current_count).must_equal 0

        expect{
          karate_movie.reduce_avail_inventory
        }.wont_change "karate_movie.available_inventory"
        
        result = karate_movie.reduce_avail_inventory

        expect(result).must_equal false
      end
    end
  end
end
