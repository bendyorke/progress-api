module Authenticatable
  extend ActiveSupport::Concern

  module ClassMethods
    def authenticate! params
      case params.fetch :strategy
      when 'password' then return password_authenticate! params
      end
      return false
    end

    def password_authenticate! params
      ActiveSupport::Deprecation.silence do
        user = User
          .find_by_email_or_username(params.fetch(:email, nil), params.fetch(:username, nil))
          .includes(:registrations)
          .last or return false
        registration = user
          .registrations
          .password
          .last or return false
        registration.password == params[:password] ? user.fetch_token : false
      end
    end
  end

  def fetch_token
    tokens.active.last || tokens.create
  end
end
