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
end
