require "test_helper"

describe Rental do
  describe "validations" do
    let(:rental) { 
      Rental.create(
        customer_id: customers(:one).id,
        movie_id: movies(:one).id,
        check_out: Date.today,
        due_date: Date.today + 7.days
      )
    }

    it "passes validations with good data" do
      expect(rental).must_be :valid?
    end

    it "rejects a rental without a check_out date" do
      rental.check_out = ""
      rental.save
      result = rental.valid?

      expect(result).must_equal false
      expect(rental.errors.messages).must_include :check_out
    end

    it "rejects a rental without a due_date" do
      rental.due_date = ""
      rental.save
      result = rental.valid?

      expect(result).must_equal false
      expect(rental.errors.messages).must_include :due_date
    end
  end
end
