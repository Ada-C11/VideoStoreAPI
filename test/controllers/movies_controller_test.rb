require "test_helper"

describe MoviesController do
  it "should get index" do
    get movies_index_url
    value(response).must_be :success?
  end

  it "should get zomg" do
    get movies_zomg_url
    value(response).must_be :success?
  end

end
