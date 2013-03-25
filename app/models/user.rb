class User < ActiveRecord::Base
  attr_accessible :login, :name, :password

  validates_presence_of :name, :login, :password
  validates_uniqueness_of :login
end
