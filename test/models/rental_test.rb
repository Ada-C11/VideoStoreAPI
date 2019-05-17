require "test_helper"

describe Rental do
  describe 'validations' do
    it 'requires a customer' do
      rental = Rental.new(customer_id: '', movie_id: 12)
      rental.valid?.must_equal false
      rental.errors.messages.must_include :customer_id
    end
    it 'requires a movie' do
      rental = Rental.new(customer_id: 12, movie_id: '')
      rental.valid?.must_equal false
      rental.errors.messages.must_include :movie_id
    end
  end

  describe 'set checkin date' do
    rental = Rental.new(
        customer_id: Customer.first.id,
        movie_id: Movie.first.id,
        checkin_date: nil,
        currently_checked_out: true
     )

     already_rented = Rental.new(
        customer_id: Customer.first.id,
        movie_id: Movie.first.id,
        checkin_date: nil,
        currently_checked_out: false
     )

    it 'sets the checkin date' do
      rental.set_checkin_date

      expect(rental.checkin_date).must_equal Date.today
      
    end

    it 'sets currently checked out to false' do
      rental.set_checkin_date

      expect(rental.currently_checked_out).must_equal false

    end

    it 'returns false if currently checked out is already false' do
      
      result = already_rented.set_checkin_date

      expect(result).must_equal false
      expect(already_rented.currently_checked_out).must_equal false
      expect(already_rented.checkin_date).must_equal nil

    end
  end
end
