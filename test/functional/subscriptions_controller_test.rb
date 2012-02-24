require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    #sign_in @user 
    #sign_out @user 
    @subscription = subscriptions(:one)
  end

  test "should get index" do
    sign_in @user
    get :index
    assert_response :success
    assert_not_nil assigns(:subscriptions)
    sign_out @user
  end
end
