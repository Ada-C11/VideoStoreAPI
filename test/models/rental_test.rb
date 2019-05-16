require "test_helper"

describe Rental do
  let (:rental) { rentals(:one) }
  
  describe "Validations" do
    it "must be valid given good data" do
      expect(rental.valid?).must_equal true
    end
    
    it "cannot be created with an invalid customer" do
      params = {
        due_date: DateTime.now,
        movie_id: movies(:one).id,
        customer_id: -1,
      }
      
      expect { Rental.new(params) }.wont_change "Rental.count"
    end
  end
  
  describe "Relationships" do
    it "is associated with a customer and a movie" do
      expect(rental.customer).wont_be_nil
      expect(rental.customer).must_be_kind_of Customer
      
      expect(rental.movie).wont_be_nil
      expect(rental.movie).must_be_kind_of Movie
    end
  end
  
  describe "Due Date" do
    it "is 7 days from the rental create date" do
      rental = rentals(:three)
      rental_date = rental.created_at

      expect(rental.set_due_date).must_equal rental_date + 7.days
      expect(rental.set_due_date).must_be_kind_of ActiveSupport::TimeWithZone   
    end
    
    it "does not set a due date for an invalid rental" do
      params = {
        movie_id: 9999999999999999999999999999,
        customer_id: 1,
      }
      
      rental = Rental.create(params)
      
      expect(rental.due_date).must_be_nil
    end
  end
end
