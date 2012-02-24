require 'test_helper'

class DentistsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    #sign_in @user 
    #sign_out @user 
    @dentist = dentists(:one)
  end

  test "should get index" do
    sign_in @user
    get :index
    assert_response :success
    assert_not_nil assigns(:dentists)
    sign_out @user
  end

  test "should get new" do
    sign_in @user
    get :new
    assert_response :success
    sign_out @user
  end

  test "should create dentist" do
    assert_difference('Dentist.count') do
    sign_in @user 
      post :create, dentist: @dentist.attributes
      sign_out @user
    end

    assert_redirected_to dentist_path(assigns(:dentist))
  end

  test "should show dentist" do
    sign_in @user
    get :show, id: @dentist
    assert_response :success
    sign_out @user
  end

  test "should get edit" do
    sign_in @user
    get :edit, id: @dentist
    sign_out @user
    assert_response :success
  end

  test "should update dentist" do
    sign_in @user
    put :update, id: @dentist, dentist: @dentist.attributes
    sign_out @user
    assert_redirected_to dentist_path(assigns(:dentist))
  end

  test "should destroy dentist" do
    assert_difference('Dentist.count', -1) do
      sign_in @user
      delete :destroy, id: @dentist
      sign_out @user
    end
    assert_redirected_to dentists_path
  end
end
