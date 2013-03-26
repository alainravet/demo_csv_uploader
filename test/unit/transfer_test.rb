require 'test_helper'

class TransferTest < ActiveSupport::TestCase
  def setup
    @user1= User.create! name: 'User 1',     login: 'user1',  password: 'test',  password_confirmation: 'test'
    @user1.account.balance = 100
    @user2= User.create! name: 'User 2',     login: 'user2',  password: 'test',  password_confirmation: 'test'
    @user2.account.balance = 200
  end

  def test_setup
    assert_equal 100, @user1.account.balance
    assert_equal 200, @user2.account.balance
  end


  test 'transfering money between 2 accounts updates the balances accordingly-NEWNEW' do
    tr = Transfer.new(origin: @user1.account, destination: @user2.account, amount: 24)
    assert  tr.valid?
    tr.save!
    assert_equal 100-24, @user1.account.balance
    assert_equal 200+24, @user2.account.balance
  end

  test "you cannot transfer money to yourself-NEWNEW" do
    tr = Transfer.new(origin: @user1.account, destination: @user1.account, amount: 24)
    assert  !tr.valid?
  end

  test 'you cannot transfer more than what you have-NEWNEW' do
    tr = Transfer.new(origin: @user1.account, destination: @user2.account, amount: 1 + @user1.balance)
    assert    !tr.valid?
  end


  test 'transfering money between 2 accounts updates the balances accordingly' do
    tr = Transfer.perform(@user1.account, @user2.account, 24)
    assert tr.valid?
    assert_equal 100-24, @user1.account.balance
    assert_equal 200+24, @user2.account.balance
  end


  def test_transfering_money_between_2_accounts_creates_a_transfer_record
    bef = Transfer.count
    Transfer.perform(@user1.account, @user2.account, 24)
    assert_equal 1+bef, Transfer.count
  end

end
