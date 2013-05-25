require 'test_helper'

class CsvFilesControllerTest < ActionController::TestCase
  setup do
    @csv_file = csv_files(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:csv_files)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create csv_file" do
    assert_difference('CsvFile.count') do
      post :create, csv_file: { name: @csv_file.name }
    end

    assert_redirected_to csv_file_path(assigns(:csv_file))
  end

  test "should show csv_file" do
    get :show, id: @csv_file
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @csv_file
    assert_response :success
  end

  test "should update csv_file" do
    put :update, id: @csv_file, csv_file: { name: @csv_file.name }
    assert_redirected_to csv_file_path(assigns(:csv_file))
  end

  test "should destroy csv_file" do
    assert_difference('CsvFile.count', -1) do
      delete :destroy, id: @csv_file
    end

    assert_redirected_to csv_files_path
  end
end
