require "test_helper"

describe RentalsController do
  let (:customer) { customers(:one) }
  let (:movie) { movies(:one) }

  describe "check-in" do
    let(:checkin_params) {
      {customer_id: customer.id,
       movie_id: movie.id}
    }

    it "decreases customers movies checked out count" do
      checkout_count = customer.movies_checked_out_count
      post checkin_path, params: checkin_params

      expect(customer.movies_checked_out_count).must_equal checkout_count - 1
    end
  end
end
