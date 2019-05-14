require "test_helper"

describe CustomersController do
  describe "index" do
    it "can render without crashing" do
      get customers_path

      must_respond_with :ok
    end
  end
  # it "should get index" do
  #   get customers_index_url
  #   value(response).must_be :success?
  # end

end
