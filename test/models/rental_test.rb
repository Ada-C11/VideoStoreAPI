require "test_helper"

describe Rental do
  let(:rental) { rentals(:one) }

  it "must be valid" do
    expect(rental.valid?).must_equal true
  end
  describe "relations" do
    it "can have a customer" do
      rental.customer.must_equal customers(:one)
    end
    it "can set a customer" do
      customer = customers(:one)
      rental = Rental.new(customer_id: customer.id, movie_id: 3 )

      rental.customer.id.must_equal customer.id
    end
    it "can have a movie" do
      rental.movie.must_equal movies(:one)
    end
    it "can set a movie" do
      movie = movies(:one)
      rental = Rental.new(customer_id: 5, movie_id: movie.id )

      rental.movie.id.must_equal movie.id
    end
    describe "custom method" do
      it "can set the checkout and due date" do
        customer = customers(:one)
        movie = movies(:one)

        rental = Rental.new(customer_id: customer.id, movie_id: movie.id)
        rental.save
  

        expect(rental.check_out).must_equal Date.today
        expect(rental.due_date).must_equal Date.today + 7.days
      end
    end

  end
end
