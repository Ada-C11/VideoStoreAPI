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
      
    end

    it "invalid movie does not have a title" do

    end
  end
end
