require 'test_helper'

class AudioRecordControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get example1" do
    get :example1
    assert_response :success
  end

  test "should get example2" do
    get :example2
    assert_response :success
  end

end
