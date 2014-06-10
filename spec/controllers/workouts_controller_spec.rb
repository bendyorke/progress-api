require 'spec_helper'

describe WorkoutsController, :type => :controller do

  context '#index' do
    it 'returns a list of all workouts' do
      workouts = create_list :workout, rand(10) + 1

      get :index

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['workouts'].length).to eq workouts.length
    end
  end

end
