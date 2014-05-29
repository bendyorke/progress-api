class Exercise < ActiveRecord::Base
  has_many   :exercises_muscle_groups
  has_many   :exercise_configs
  has_many   :follows, as: :followable
  has_many   :workouts,        through: :exercise_configs
  has_many   :users,           through: :exercise_configs
  has_many   :muscle_groups,   through: :exercises_muscle_groups
  has_many   :followers,       through: :follows, source: :user
  belongs_to :primary_muscle_group, class_name: "MuscleGroup"
  belongs_to :user
end
