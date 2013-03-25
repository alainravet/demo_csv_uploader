class User < ActiveRecord::Base
  attr_accessible :login, :name, :password

  validates_presence_of :name
  validates_presence_of :login
  validates_presence_of :password

end
