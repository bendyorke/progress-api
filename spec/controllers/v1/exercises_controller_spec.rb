require 'spec_helper'

describe Api::V1::ExercisesController, :type => :controller do
  context '#index' do
    it 'returns a list of all exercises' do
      exercises = create_list :exercise, rand(3) + 1

      get :index

      successful_response
      expect(Exercise.all.count).to eq exercises.count
    end
  end
end
