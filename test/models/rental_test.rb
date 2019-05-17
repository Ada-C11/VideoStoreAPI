# frozen_string_literal: true

require 'test_helper'
require 'pry'

describe Rental do
  let(:rental) { Rental.new(customer_id: customers(:joe).id, movie_id: movies(:one).id) }
  let(:customer) { customers(:joe) }

  describe 'validations' do
    it 'must be valid' do
      value(rental).must_be :valid?
    end

    it 'must have a customer' do
      rental.customer_id = nil
      rental.save
      expect(rental.valid?).must_equal false
      expect(rental.errors).must_include 'customer'
    end

    it "must have a movie" do
      rental.movie_id = nil
      rental.save
      expect(rental.valid?).must_equal false
      expect(rental.errors).must_include "movie"
    end
  end

  describe "relationships" do
    it "belongs to a customer" do
      rental.save
      expect(rental).must_respond_to :customer
    end

    it "belongs to a movie" do
      rental.save
      expect(rental).must_respond_to :movie
    end
  end
end
