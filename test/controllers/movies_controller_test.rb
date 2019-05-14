require "test_helper"

describe MoviesController do
  describe "index" do
    it "is a working route that returns a JSON array" do
      get movies_path

      must_respond_with :success
      expect(response.header["Content-Type"]).must_include "json"

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    # it "" do

    # end
  end
end
