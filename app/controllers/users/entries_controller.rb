class Users::EntriesController < ApplicationController

  before_filter :authenticate_requests

  def create
    @entry = Entry.create entry_params
    render :json => @entry
  end

  private

    def entry_params
      params.require(:entry).permit!.merge(user_id: current_user.id)
    end

end
