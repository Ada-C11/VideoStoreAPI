require "test_helper"

describe RentalsController do
  let(:rental_data) {
    {
      movie_id: movies(:one).id,
      customer_id: customers(:chewy).id,
      check_out: Date.today,
      due_date: Date.today + 7,
    }
  }
  describe "checkout" do
    it "should create a rental given valid data" do
      expect {
        post rentals_check_out_path, params: rental_data
      }.must_change "Rental.count", +1

      must_respond_with :success
    end
  end
end
