class User < ActiveRecord::Base
  has_many :entries
  has_many :workouts
  has_many :exercises
  has_many :exercise_configs
  has_many :followings, class_name: 'Follow'
  has_many :follows, as: :followable
  has_many :followers, through: :follows, source: :user
  has_many :tokens
  has_many :registrations

  include Authenticatable

  scope :find_by_email_or_username, -> (email, username) { where('email = ? OR username = ?', email, username).limit(1) }
end
