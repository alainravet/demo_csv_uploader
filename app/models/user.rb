class User < ActiveRecord::Base

  has_secure_password

  attr_accessible :login, :name, :password, :password_confirmation

  validates_presence_of :name, :login
  validates_uniqueness_of :login
end
