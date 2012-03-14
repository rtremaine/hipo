require 'test_helper'

class RecordSetsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    sign_in @user 
    @record_set = record_sets(:one)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create record_set" do
    assert_difference('RecordSet.count') do
      post :create, record_set: @record_set.attributes
    end

    assert_redirected_to record_set_path(assigns(:record_set))
  end

  test "should show record_set" do
    get :show, id: @record_set
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @record_set
    assert_response :success
  end

  test "should update record_set" do
    put :update, id: @record_set, record_set: @record_set.attributes
    assert_redirected_to record_set_path(assigns(:record_set))
  end

  test "should destroy record_set" do
    assert_difference('RecordSet.count', -1) do
      delete :destroy, id: @record_set
    end

    assert_redirected_to record_sets_path
  end
end
