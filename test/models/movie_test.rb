require "test_helper"

describe Movie do
  describe 'relations' do
    it 'has a customer' do
      movie = movies(:pride)
      expect(movie).must_respond_to :customers
    end

    it "has a rental" do
      movie = movies(:pride)
      rental = Rental.new(movie_id: Movie.first.id, customer_id: Customer.first.id)
      
      expect(movie).must_respond_to :rentals
    end
  end

  describe 'validations' do
    it 'requires a title' do
      movie = Movie.new(overview: 'this is jupiter', release_date: 2017-03-14, inventory: -1)
      movie.valid?.must_equal false
      movie.errors.messages.must_include :title
    end
    it 'requires an overview' do
      movie = Movie.new(title: 'Jupiter Tour', release_date: 2017-03-14, inventory: -1)
      movie.valid?.must_equal false
      movie.errors.messages.must_include :overview
    end
    it 'requires a release date' do
      movie = Movie.new(title: 'Jupiter Tour', overview: 'this is jupiter', inventory: -1)
      movie.valid?.must_equal false
      movie.errors.messages.must_include :release_date
    end
    it 'requires inventory' do
      movie = Movie.new(title: 'Jupiter Tour', overview: 'this is jupiter', release_date: 2017-03-14)
      movie.valid?.must_equal false
      movie.errors.messages.must_include :inventory
    end
    it 'requires a inventory to be greater than 0' do
      movie = Movie.new(title: 'Jupiter Tour', overview: 'this is jupiter', release_date: 2017-03-14, inventory: -1)
      movie.valid?.must_equal false
      movie.errors.messages.must_include :inventory
    end
  end
end
