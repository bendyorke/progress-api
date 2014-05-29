class Workout < ActiveRecord::Base
  has_many   :exercise_configs
  has_many   :follows, as: :followable
  has_many   :exercises, through: :exercise_configs
  has_many   :users,     through: :exercise_configs
  has_many   :followers, through: :follows,     source: :user
  has_many   :forks,     class_name: "Workout"
  belongs_to :original,  class_name: "Workout", foreign_key: "workout_id"
  belongs_to :user

  def fork user_id = nil
    fork = self.dup and fork.update_attributes(
      workout_id: self.id,
      exercises:  self.exercises,
      user_id:    user_id
    )
    fork
  end
end
