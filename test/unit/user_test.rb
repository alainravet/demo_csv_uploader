require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def test_valid_user
    assert User.new(valid_user_parameters).valid?
  end

  def test_user_must_have_a_name     ; assert !User.new(valid_user_parameters.except(:name    )).valid? end
  def test_user_must_have_a_login    ; assert !User.new(valid_user_parameters.except(:login   )).valid? end
  def test_user_must_have_a_password ; assert !User.new(valid_user_parameters.except(:password)).valid? end

private
  def valid_user_parameters
    {:name => 'aname', :login => 'alogin', :password => 'apassword'}
  end

end
