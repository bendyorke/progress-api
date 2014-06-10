class TokensController < ApplicationController
  before_filter :authenticate_requests
  def index
    render :json => token
  end
end
