require "test_helper"
 
describe Movie do
  let(:movie) { movies(:aladdin) }


  describe "relationships" do
    it "has rentals" do 
      expect(movie.rentals).must_respond_to :each
    end
  end

  describe "validations" do
    it "valid movie has a title" do
      expect(movie).must_be :valid?
    end

    it "invalid movie does not have a title" do
      movie.title = nil
      expect(movie).wont_be :valid?
    end

    it "invalid movie has no inventory" do
      movie.inventory = nil
      expect(movie).wont_be :valid?
    end

    it "invalid if inventory is a negative number" do
      movie.inventory = -10
      expect(movie).wont_be :valid?
    end
  end
end
