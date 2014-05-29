class Api::V1::Users::Workouts::ExercisesController < Api::V1::V1ApplicationController

  def index
    @config = ExerciseConfig
      .where(workout_id: params[:workout_id], user_id: params[:user_id])
      .includes :exercise, :workout
    render :json => @config
  end

  def create
    @config = ExerciseConfig.create create_config_params
    render :json => @config.exercise
  end

  private
    def create_config_params
      params.permit :user_id, :exercise_id, :workout_id
    end

end
