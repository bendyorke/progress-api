class Api::V1::V1ApplicationController < ApplicationController
  private
    def token_params
      params.permit(:user_id)
    end
end
