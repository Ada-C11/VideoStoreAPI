require "test_helper"

describe Rental do
  let(:rental) { Rental.new(checkout_date: Time.now, due_date: Time.now + 2, customer: Customer.first, movie: Movie.first) }

  it 'does returns error has if movie is unavailiable' do
    rental.movie.inventory = 0

    rental.save 
    error_messages = rental.errors.messages 
    expect(error_messages).must_include :movie
    expect(error_messages).must_be_kind_of Hash
  end 


end
