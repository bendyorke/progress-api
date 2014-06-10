require 'bcrypt'
class Registration < ActiveRecord::Base
  include BCrypt
  belongs_to :user

  scope :password, -> { where(strategy: 'password') }

  store_accessor :authorization, :password_hash

  def password
    @password ||= Password.new password_hash
  end

  def password= new_password
    @password = Password.create new_password
    self.password_hash = @password
  end
end
