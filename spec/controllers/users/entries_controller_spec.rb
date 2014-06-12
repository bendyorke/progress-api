require 'spec_helper'

describe Users::EntriesController, :type => :controller do
  context '#index' do
    it 'can pull all entries for a user' do
      user    = create :user_with_password
      entries = create_list :entry, rand(3), user: user
      authenticate user
      get :index, user_id: user.id

      json = successful_json_response
      expect(json['entries'].length).to eq entries.length
    end

    it 'can pull all entries for a user, exercise, and workout' do
      user     = create :user_with_password
      workout  = create :workout_with_exercises, user: user
      exercise = workout.exercises.sample
      entries  = create_list :entry, rand(3), user: user, workout: workout, exercise: exercise
      entry    = create :entry, user: user, workout: workout
      authenticate user
      get :index, user_id: user.id, entry: { workout_id: workout.id, exercise_id: exercise.id }

      json = successful_json_response
      expect(json['entries'].length).to eq entries.length
    end
  end

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
