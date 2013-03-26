class User < ActiveRecord::Base
  after_create  :create_linked_account

  delegate :balance, :balance_in_cents, to: :account

  def create_linked_account
    self.build_account(balance: 0).save!
  end


  has_one :account
  has_many :transfers, :class_name => "Transfer", :foreign_key => "origin_id"
  has_many :transfers_credit, :class_name => "Transfer", :foreign_key => "destination_id"

  has_secure_password

  attr_accessible :login, :name, :password, :password_confirmation

  validates_presence_of :name, :login
  validates_uniqueness_of :login

  def admin?
    login == 'admin'
  end
end
