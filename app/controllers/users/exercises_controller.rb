class Users::ExercisesController < ApplicationController
  before_filter :authenticate_requests

  def index
    @exercises = current_user.exercises
    render :json => @exercises
  end

  def create
    @exercise = current_user.exercises.create exercise_params
    render :json => @exercise
  end

  def update
    @exercise = current_user.exercises.find params[:id]
    if @exercise.update exercise_params
      render :json => @exercise
    else
      render :json => @exercise.errors, :status => :unprocessable_entity
    end
  end

  private
    def exercise_params
      params.require(:exercise).permit!
    end

end
