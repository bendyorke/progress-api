require 'spec_helper'

describe ExercisesController, :type => :controller do
  context '#index' do
    it 'returns a list of all exercises' do
      exercises = create_list :exercise, rand(3) + 1

      get :index

      json = successful_json_response
      expect(json['exercises'].count).to eq exercises.count
    end
  end
end
