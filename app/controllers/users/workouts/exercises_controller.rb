class Users::Workouts::ExercisesController < ApplicationController

  before_filter :authenticate_requests
  before_filter :authorize_requests, only: %i[update]

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

  def update
    @config = ExerciseConfig.find config_search_params
    if @config.update config_params
      render :json => @config.exercise
    else
      render :json => @workout.errors, :status => :unprocessable_entity
    end
  end

  private
    def create_config_params
      params.permit :user_id, :exercise_id, :workout_id
    end

    def config_search_params
      params.permit(:exercise_id, :workout_id).merge(user_id: current_user.id)
    end

    def config_params
      params.require(:config).permit!
    end

end
