class ZomgController < ApplicationController
  def index
    render status: :ok, json: { message: "it works!" }
  end
end
