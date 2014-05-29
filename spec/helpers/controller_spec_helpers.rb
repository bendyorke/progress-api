module ControllerSpecHelpers
  def successful_response
    expect(response).to be_success
  end

  def successful_json_response
    successful_response
    JSON.parse(response.body)
  end
end
