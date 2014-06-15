class Users::EntriesController < ApplicationController

  before_filter :authenticate_requests
  before_filter :authorize_user, only: [:create]

  def index
    @entries = subject_user.entries.where entry_params
    render :json => @entries
  end

  def create
    @entry = Entry.create entry_params
    render :json => @entry
  end

  private

    def entry_params
      params.permit(entry: [:workout_id, :exercise_id]).fetch(:entry, {}).merge(user_id: subject_user.id)
    end

end

