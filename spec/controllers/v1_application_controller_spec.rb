require 'spec_helper'

describe 'ApplicationController', :type => :controller do
  context Users::WorkoutsController do
    describe '#authenticate' do
      it 'authenticates with a token' do
        user  = create :user_with_password
        token = create :token, user_id: user.id
        authenticate user

        get :index, user_id: user.id

        successful_response
      end
    end
  end
end
