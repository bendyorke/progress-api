class ExerciseField < ActiveRecord::Base
  has_many :exercises_exercise_fields
  has_many :exercises, through: :exercises_exercise_fields
end
