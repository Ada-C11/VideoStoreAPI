require "test_helper"

describe ZomgController do
  it "should get index" do
    get zomg_index_url
    value(response).must_be :success?
  end

end
