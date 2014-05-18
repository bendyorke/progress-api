class Workout < ActiveRecord::Base
  has_many :exercises_workouts
  has_many :exercises, through: :exercises_workouts
end
