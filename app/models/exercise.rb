class Exercise < ActiveRecord::Base
  has_many   :exercises_workouts
  has_many   :exercises_exercise_fields
  has_many   :exercises_muscle_groups
  has_many   :follows, as: :followable
  has_many   :workouts,        through: :exercises_workouts
  has_many   :exercise_fields, through: :exercises_exercise_fields
  has_many   :muscle_groups,   through: :exercises_muscle_groups
  has_many   :followers,       through: :follows, source: :user
  belongs_to :primary_muscle_group, class_name: "MuscleGroup"
  belongs_to :user
end
