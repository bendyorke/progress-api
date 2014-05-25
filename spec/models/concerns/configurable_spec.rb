require 'spec_helper'

describe Configurable do
  subject(:exercise) {
    Exercise.new name: "Curls",
              user_id: 0,
               fields: { "weight" => "tons" }
  }

  context 'When user owns exercise' do
    it 'gets existing data from hstore' do
      expect(exercise.weight({ user_id: 0 })).to eq "tons"
    end

    it 'sets existing data in hstore', focus: true do
      exercise.weight = { value: "pounds", user_id: 0 }
      expect(exercise.weight({ user_id: 0 })).to eq "pounds"
    end

    it 'gets nil for undefined data from hstore' do
      expect(exercise.time({ user_id: 0 })).to eq nil
    end

    it 'sets undefined data in hstore' do
      exercise.time = { value: "seconds", user_id: 0 }
      expect(exercise.time({ user_id: 0 })).to eq "seconds"
    end

    it 'can neither get nor set unspecified fields in hstore' do
      expect{exercise.foo}.to raise_error NoMethodError
      expect{exercise.foo = :bar}.to raise_error NoMethodError
    end

    it 'clears a key from field in hstore when set to nil' do
      exercise.weight = { value: nil, user_id: 0 }
      expect(exercise.fields.keys).to eq []
    end

  end

  context 'When user does not own exercise' do
  end
end
