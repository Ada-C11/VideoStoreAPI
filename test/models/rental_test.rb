require "test_helper"

describe 'Rental' do
  let(:customer) {Customer.first}
  let(:movie) {Movie.first}
  let(:rental) { Rental.new(checkout_date: Time.now, due_date: Time.now + 2, customer: customer, movie: movie) }
  describe 'validations' do
    it 'passes validations with good data' do
      movie.inventory = 2
      expect(rental).must_be :valid?
    end 

    it "does returns has if movie is unavailiable" do
      movie.inventory = 0
      expect(rental.valid?).must_equal false
    end

    it 'requires checkout date' do
      rental.checkout_date = nil
      expect(rental.valid?).must_equal false
    end 

    it "requires a due date" do
      rental.due_date = nil
      expect(rental.valid?).must_equal false
    end
  end

  describe 'relationships' do
    it 'has a customer' do
      expect(rental.customer_id).must_equal customer.id 
      
      rental.customer_id = nil
      expect(rental.valid?).must_equal false

    end 

    it 'has a movie' do
      expect(rental.movie_id).must_equal movie.id 
      
      rental.movie_id = nil

      # will raise a NoMethodError b/c can't run the is_availiable method on nil
      expect{rental.valid?}.must_raise NoMethodError
    end
  end 

  describe "is_availiable?" do
    it "returns nil if rental is availiable" do
      movie.inventory = 2

      expect(rental.movie.inventory).must_be :>, 0
      expect(rental.is_available?).must_be_nil
    end

    it "returns error if movie's inventory is 0" do
      movie.inventory = 0

      expect(movie.inventory).must_equal 0
      expect(rental.is_available?).must_be_kind_of Array 
    end
  end
end
