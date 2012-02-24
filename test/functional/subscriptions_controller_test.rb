require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    #sign_in @user 
    #sign_out @user 
    @subscription = subscriptions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subscriptions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subscription" do
    assert_difference('Subscription.count') do
      sign_in @user
      post :create, subscription: @subscription.attributes
      sign_out @user
    end

    assert_redirected_to subscription_path(assigns(:subscription))
  end

  test "should show subscription" do
    get :show, id: @subscription
    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get :edit, id: @subscription
    assert_response :success
    sign_out @user
  end

  test "should update subscription" do
    sign_in @user
    put :update, id: @subscription, subscription: @subscription.attributes
    assert_response :success
    sign_out @user
    #assert_redirected_to subscription_path(assigns(:subscription))
  end

  test "should destroy subscription" do
    assert_difference('Subscription.count', -1) do
      sign_in @user
      delete :destroy, id: @subscription
      sign_out @user
    end

    assert_redirected_to subscriptions_path
  end
end
