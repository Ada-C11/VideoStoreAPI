require "test_helper"

describe RentalsController do
  describe "creating rental" do
    let(:rental_data) {
      {
        movie_id: movies(:one).movie_id,
        customer_id: customers(:one).id,
      }
    }

    it "can create a new rental provided valid data" do
      expect {
        post rental_path, params: rental_data
      }.must_change "Rental.count", +1
    end
  end
end
