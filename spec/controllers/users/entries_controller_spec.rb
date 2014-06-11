require 'spec_helper'

describe Users::EntriesController, :type => :controller do
  context '#create' do
    it 'can creates an entry with a user, workout, and exercise' do
      user     = create :user_with_password
      workout  = create :workout_with_exercises, user: user
      exercise = workout.exercises.sample
      authenticate user
      post :create, user_id: user.id, entry: { workout_id: workout.id, exercise_id: exercise.id }

      successful_response
      expect(Entry.last.workout_id).to  eq workout.id
      expect(Entry.last.exercise_id).to eq exercise.id
      expect(Entry.last.user_id).to     eq user.id
    end
  end
end
