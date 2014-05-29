class Api::V1::Users::WorkoutsController < Api::V1::V1ApplicationController

  def index
    @workouts = Workout.where token_params
    render :json => @workouts
  end

  def create
    if fork_params_id
      @workout = Workout.find(fork_params_id).fork(token_params[:user_id])
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
