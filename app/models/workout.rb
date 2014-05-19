class Workout < ActiveRecord::Base
  has_many   :exercises_workouts
  has_many   :follows, as: :followable
  has_many   :exercises, through: :exercises_workouts
  has_many   :followers, through: :follows, source: :user
  belongs_to :user
end
