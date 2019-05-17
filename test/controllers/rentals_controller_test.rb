require "test_helper"

describe RentalsController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end
  before do
    @params = {customer_id: customers(:shelley).id, movie_id: movies(:other_test).id}
  end
  describe "checkout" do
    it "customer can checkout and create a new rental" do
      expect {
        post checkout_path, params: @params
      }.must_change "Rental.count", 1

      expect(response.header["Content-Type"]).must_include "json"
      expect(Rental.last.due - Rental.last.checkout).must_be_close_to 604800
      expect(Rental.last.returned).must_equal false
    end

    it "movie availble inventory decreases" do
      before = movies(:other_test).number_available

      post checkout_path, params: @params
      movies(:other_test).reload
      expect(movies(:other_test).number_available).must_equal before - 1
    end
  end

  describe "checkin" do
    it "customer can checkin a rental" do
      post checkout_path, params: @params

      expect {
        post checkin_path, params: @params
      }.wont_change "Rental.count"

      expect(response.header["Content-Type"]).must_include "json"
      expect(Rental.last.returned).must_equal true
    end

    it "movie available inventory increases" do
      post checkout_path, params: @params
      before = movies(:other_test).number_available

      post checkin_path, params: @params
      movies(:other_test).reload
      expect(movies(:other_test).number_available).must_equal before + 1
    end
  end
end
