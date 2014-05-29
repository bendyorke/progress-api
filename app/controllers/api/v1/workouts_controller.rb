class Api::V1::WorkoutsController < Api::V1::V1ApplicationController

  def index
    @workouts = Workout.all
    render :json => @workouts
  end
end
