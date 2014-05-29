class ExerciseConfig < ActiveRecord::Base
  belongs_to :exercise
  belongs_to :workout
  belongs_to :user

  include Configurable
  config_accessor :config, :reps, :weight, :time

  before_create :add_user_id

  def add_user_id
    self.user_id = self.workout.user_id
  end
end
