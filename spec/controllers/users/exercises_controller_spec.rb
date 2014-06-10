require 'spec_helper'

describe Users::ExercisesController, :type => :controller do
  context '#index' do
    it 'returns all workouts belonging to a user' do
      user = create :user_with_exercises
      create :user_with_exercises
      authenticate user
      get :index, user_id: user.id

      json = successful_json_response
      expect(json['exercises'].count).to eq user.exercises.count
    end
  end

  context '#create' do
    it 'returns a workout with an id' do
      user = create :user
      authenticate user
      post :create, user_id: user.id, exercise: build(:exercise).attributes

      json = successful_json_response
      expect(json['exercise']).to have_key 'id'
    end

    it 'saves the exercise to a user' do
      user = create :user
      authenticate user
      post :create, user_id: user.id, exercise: build(:exercise, user_id: user.id).attributes

      json = successful_json_response
      expect(json['exercise']['id']).to eq user.exercises.last.id
    end
  end

  context '#update' do
    it 'can update basic attributes' do
      user = create :user_with_exercises
      attributes = build(:exercise).attributes.except("id")
      authenticate user
      put :update, user_id: user.id, id: user.exercises.last.id, exercise: attributes

      json = successful_json_response
      expect(json['exercise']['name']).to eq attributes['name']
    end
  end
end
