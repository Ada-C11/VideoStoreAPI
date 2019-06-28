class ApplicationController < ActionController::API
  def test
    render json: { test_message: "It works!" }
  end
end
