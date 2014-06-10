require 'spec_helper'

describe Users::Workouts::ExercisesController, :type => :controller do
  context '#create' do
    it 'can add an exercise to a workout' do
      user     = create :user
      workout  = create :workout
      exercise = create :exercise

      post :create, workout_id: workout.id, exercise_id: exercise.id, user_id: user.id

      successful_response
      expect(workout.exercises.last.id).to eq exercise.id
    end
  end

  context '#index' do
    it 'returns the exercises and configs for a workout' do
      user = create :user_with_workouts_with_exercises

      get :index, workout_id: user.workouts.last.id, user_id: user.id

      json = successful_json_response
      expect(json['exercises'].first).to have_key "config"
    end
  end
end
