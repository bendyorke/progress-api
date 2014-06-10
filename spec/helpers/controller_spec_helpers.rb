module ControllerSpecHelpers
  def authenticate user = nil
    if user
      token = Token.where(user_id: user.id).first || create(:token, user_id: user.id)
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(token.hex)
    else
      controller.stub(:authenticate => true)
    end
  end

  def successful_response
    expect(response).to be_success
  end

  def successful_json_response
    successful_response
    JSON.parse(response.body)
  end
end
