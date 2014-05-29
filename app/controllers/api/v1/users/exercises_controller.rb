class Api::V1::Users::ExercisesController < Api::V1::V1ApplicationController

  def index
    @exercises = Exercise.where token_params
    render :json => @exercises
  end

  def create
    @exercise = Exercise.create exercise_params
    render :json => @exercise
  end

  def update
    @exercise = Exercise.find params[:id]
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
