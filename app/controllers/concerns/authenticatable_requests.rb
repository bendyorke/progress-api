module AuthenticatableRequests
  extend ActiveSupport::Concern

  def token
    @_token
  end

  def current_user
    @_current_user ||= (token ? token.user : nil)
  end

  def subject_user
    @_subject_user ||= (params[:user_id] ? User.find(params[:user_id]) : nil)
  end

  protected
    def authenticate_requests
      token_authentication! || params_authentication! || forbidden!
    end

    def token_authentication!
      @_token = authenticate_with_http_token { |token, options| Token.where(hex: token).includes(:user).first }
    end

    def params_authentication!
      @_token = User.authenticate! authentication_params[:authentication]
    end

    def authentication_params
      params.permit(:authentication => [:strategy, :email, :username, :password])
    end

    def forbidden!
      head :forbidden
    end

    def authorize_user
      current_user_is_subject_user? || not_authorized!
    end

    def current_user_is_subject_user?
      current_user && subject_user && current_user == subject_user
    end

    def not_authorized!
      head :unauthorized
    end

end
