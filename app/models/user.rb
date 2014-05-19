class User < ActiveRecord::Base
  has_many :workouts
  has_many :exercises
  has_many :follows
  has_many :followables, as: :followable, class_name: 'Follow'
  has_many :followers, through: :followables, source: :user
end
