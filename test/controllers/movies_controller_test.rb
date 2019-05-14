require "test_helper"

describe MoviesController do
  describe "index" do
    it "can redner without crashing" do
      get movies_path

      must_respond_with :ok
    end
  end
  # it "should get index" do
  #   get movies_index_url
  #   value(response).must_be :success?
  # end

  # it "should get zomg" do
  #   get movies_zomg_url
  #   value(response).must_be :success?
  # end

end
