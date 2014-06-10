class Users::WorkoutsController < ApplicationController
  before_filter :authenticate_requests
  def index
    @workouts = current_user.workouts
    render :json => @workouts
  end

  def create
    if fork_params_id
      @workout = Workout.find(fork_params_id).fork(current_user.id)
    else
      @workout = Workout.create workout_params
    end
    render :json => @workout
  end

  def update
    @workout = Workout.find params[:id]
    if @workout.update workout_params
      render :json => @workout
    else
      render :json => @workout.errors, :status => :unprocessable_entity
    end
  end

  private
    def fork_params
      params.require(:workout).permit(:workout_id)
    end

    def fork_params_id
      fork_params.fetch :workout_id, false
    end

    def workout_params
      params.require(:workout).permit!
    end

end
