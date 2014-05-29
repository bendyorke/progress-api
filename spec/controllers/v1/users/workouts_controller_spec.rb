require 'spec_helper'

describe Api::V1::Users::WorkoutsController, :type => :controller do
  context '#index' do
    it 'returns a list of workouts' do
      user = create :user_with_workouts

      get :index, user_id: user.id

      json = successful_json_response
      expect(json['workouts'].length).to eq user.workouts.length
    end

    it 'does not include workouts from other users' do
      user = create :user_with_workouts
      create_list :user_with_workouts, 3

      get :index, user_id: user.id

      json = successful_json_response
      expect(json['workouts'].length).to eq user.workouts.length
    end
  end

  context '#create' do
    context 'Workout#create' do
      it 'without [:workout_id]' do
        post :create, workout: build(:workout).attributes.except("workout_id")

        json = successful_json_response
        expect(Workout.all.length).to eq 1
      end

      it 'with [:workout_id] = nil' do
        post :create, workout: build(:workout).attributes

        json = successful_json_response
        expect(Workout.all.length).to eq 1
      end

      it 'belongs to the user' do
        user = create :user
        post :create, workout: build(:workout, user_id: user.id).attributes

        json = successful_json_response
        expect(json['workout']['id']).to eq user.workouts.last.id
      end
    end

    context 'Workout#fork' do
      it 'forks a workout' do
        workout = create :workout
        post :create, workout: { workout_id: workout.id }

        json = successful_json_response
        expect(Workout.all.length).to eq 2
      end

      it 'belongs to the user' do
        user    = create :user
        workout = create :workout

        post :create, workout: { workout_id: workout.id }, user_id: user.id

        json = successful_json_response
        expect(json['workout']['id']).to eq user.workouts.last.id
      end
    end
  end

  context '#update' do
    it 'updates basic fields' do
      workout    = create :workout
      attributes = build(:workout).attributes.except("id")

      put :update, id: workout.id, workout: attributes

      json = successful_json_response
      expect(json['workout']['name']).to eq attributes["name"]
    end
  end
end
