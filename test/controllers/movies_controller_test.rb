require "test_helper"

describe MoviesController do
  describe "index" do
    it "is a working route" do
      get movies_path
      must_respond_with :success
    end
  end
end
