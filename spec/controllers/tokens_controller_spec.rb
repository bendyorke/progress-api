require 'spec_helper'

describe TokensController, :type => :controller do
  describe '#index' do
    context 'strategy: password' do
      it 'returns a token with proper authentication' do
        user = create :user_with_password, password: 'password'

        get :index, authentication: { strategy: 'password', email: user.email, password: 'password' }

        json = successful_json_response
        expect(json['user_id']).to eq user.id
      end

      it 'returns unauthorized without proper authentication' do
        get :index, authentication: { strategy: 'password', email: 'boo', password: 'far' }

        expect(response.status).to eq 403
      end
    end
  end
end
