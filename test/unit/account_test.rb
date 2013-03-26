require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  def setup
    @user = User.create! name: 'Test User',     login: 'test',  password: 'test',  password_confirmation: 'test'
  end

  def test_valid_account
    assert Account.new(valid_account_parameters).valid?
  end

  def test_account_must_belong_to_a_user
    assert !Account.new(valid_account_parameters.except(:user_id)).valid?
  end

  def test_account_must_have_a_positive_or_null_balance
    #valid
    assert  Account.new(valid_account_parameters.merge(balance_in_cents: 0)).valid?
    #invalid
    assert !Account.new(valid_account_parameters.except(:balance_in_cents)).valid?
    assert !Account.new(valid_account_parameters.merge(balance_in_cents: -123)).valid?
  end

  private
  def valid_account_parameters
    {user_id: @user.id, balance_in_cents: 1234}
  end

end
