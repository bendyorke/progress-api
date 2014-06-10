class RegistrationsController < ApplicationController
  def create
    Registration.create registration_params
    render nothing: true
  end

  private
    def registration_params
      params.require(:registration).permit(:user_id, :strategy, :password)
    end
end
