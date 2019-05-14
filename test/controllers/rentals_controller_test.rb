# frozen_string_literal: true

require 'test_helper'
require 'pry'

describe RentalsController do
  describe 'checkout' do
    let(:rental_data) do
      { rental:
        {
          customer_id: customers(:joe).id,
          movie_id: movies(:one).id
        } }
    end
    it 'must create a new rental' do
      expect do
        post checkout_path, params: rental_data
      end.must_change 'Rental.count'
    end

    it 'must change the available_inventory of the checked out movie' do
      count = movies(:one).available_inventory

      post checkout_path, params: rental_data

      expect(movies(:one).reload.available_inventory).must_equal count - 1
    end

    it 'must change the movies_checked_out count of the customer' do
      count = customers(:joe).movies_checked_out
    end
  end
end
