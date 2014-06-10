require 'spec_helper'

describe RegistrationsController, :type => :controller do

  describe '#create' do
    it 'can create a password registration for a user' do
      user = create :user

      post :create, registration: { user_id: user.id, strategy: 'password', password: 'secure password' }

      successful_response
      expect(user.registrations.password).to end_with Registration.last
    end
  end

end
