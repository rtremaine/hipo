require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    sign_in @user 
    @subscription = subscriptions(:one)
  end
end
