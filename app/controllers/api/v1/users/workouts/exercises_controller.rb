class Api::V1::Users::Workouts::ExercisesController < Api::V1::V1ApplicationController

  def index
    @exercises = Exercise
      .where_workout(id: params[:workout_id])
      .include_config_where(workout_id: params[:workout_id], user_id: params[:user_id])
    render :json => @exercises, each_serializer: ExerciseWithConfigSerializer
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
