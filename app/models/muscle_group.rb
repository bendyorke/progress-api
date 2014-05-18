class MuscleGroup < ActiveRecord::Base
  has_many :exercises_muscle_groups
  has_many :exercises, through: :exercises_muscle_groups
  has_many :primary_exercises, class_name: "Exercise", foreign_key: "primary_muscle_group_id"
end
