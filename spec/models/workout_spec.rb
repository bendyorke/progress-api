require 'spec_helper'

describe Workout do
  let(:workout) do
    Workout.where(name: "Chest and Tris").first_or_create
  end
  let(:user) { User.where(first_name: "Ender").first_or_create }

  describe '#fork' do
    let(:fork) do
      workout.fork user.id
    end
    it 'saves workout to user' do
      expect(fork.user_id).to eq user.id
    end

    it 'saves original workout' do
      expect(fork.workout_id).to eq workout.id
    end
  end
end
