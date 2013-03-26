class Account < ActiveRecord::Base

  attr_accessible :balance_in_cents, :balance, :user_id

  belongs_to :user
  validates_presence_of :user_id, :balance_in_cents
  validates_numericality_of :balance_in_cents,
                            greater_than_or_equal_to: 0,
                            only_integer: true,
                            allow_nil: false

  def balance
    balance_in_cents / 100.00
  end

  def balance=(value)
    self.balance_in_cents= (value * 100).to_i
  end

  def label_method
    "Account #1 of : #{user.login}"
  end
end
