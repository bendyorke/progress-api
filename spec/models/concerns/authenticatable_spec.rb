require 'spec_helper'

describe Authenticatable do
  describe '#authenticate!' do
    it 'calls the appropriate authentication function' do
      user = create :user_with_password, password: 'secure'
      User.stub :password_authenticate!
      expect(User).to receive(:password_authenticate!)
      User.authenticate! strategy: 'password', user_id: user.id, email: user.email, password: 'secure'
    end
  end

  describe '#password_authenticate!' do
    it 'returns a token with valid credentials' do
      user  = create :user_with_password, password: 'secure'
      token = User.authenticate! strategy: 'password', email: user.email, password: 'secure'
      expect(token).to eq Token.last
    end

    it 'returns false with invalid credentials' do
      token = User.authenticate! strategy: 'password', email: 'email', password: 'secure'
      expect(token).to be false
    end
  end
end
