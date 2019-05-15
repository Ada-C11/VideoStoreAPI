# frozen_string_literal: true

require 'test_helper'
require 'pry'

describe Rental do
  let(:rental) { Rental.new(customer_id: customers(:joe).id, movie_id: movies(:one).id) }

  it 'must be valid' do
    value(rental).must_be :valid?
  end
end
