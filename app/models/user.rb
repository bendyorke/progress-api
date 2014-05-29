class User < ActiveRecord::Base
  has_many :workouts
  has_many :exercises
  has_many :exercise_configs
  has_many :followings, class_name: 'Follow'
  has_many :follows, as: :followable
  has_many :followers, through: :follows, source: :user
end
