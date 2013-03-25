class User < ActiveRecord::Base
  attr_accessible :login, :name, :password
end
