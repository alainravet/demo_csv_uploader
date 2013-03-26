class User < ActiveRecord::Base
  after_create  :create_linked_account

  delegate :balance, to: :account

  def create_linked_account
    self.build_account(balance: 0).save!
  end


  has_one :account

  has_secure_password

  attr_accessible :login, :name, :password, :password_confirmation

  validates_presence_of :name, :login
  validates_uniqueness_of :login

  def admin?
    login == 'admin'
  end
end
