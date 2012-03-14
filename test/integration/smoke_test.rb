require 'integration_test_helper'

class SmokeTest < ActionController::IntegrationTest
  require 'capybara/rails'
  #Capybara.default_driver = :selenium

  test '1 sign up and subscribe' do
    visit '/users/sign_up'
    assert page.has_content?('Forgot your password?')
    fill_in "user_email", :with=> "thealey@gmail.com"
    fill_in "user_password", :with=> "bondaxe"
    fill_in "user_password_confirmation", :with=> "bondaxe"
    click_button "Sign up"
    assert page.has_content?('Welcome! You have signed up successfully.')
    assert page.has_content?('thealey@gmail.com')
    u = User.find_by_email 'thealey@gmail.com'
    visit '/users/' + u.id.to_s
    assert page.has_content?('No active subscription')
    visit '/subscriptions'
    assert page.has_content?('You must be an administrator to access this section')
  end

  test '2 subscribe with stripe' do
    if false
      assert page.has_content?('Subscribe')
      click_link 'Subscribe'
      fill_in "name", :with=> 'Ted Healey'
      fill_in "card_number", :with=> '4242424242424242'
      fill_in "address_zip", :with=> '02043'
      fill_in "card_code", :with=> '123'
      select "January", :from=> 'card_month'
      select "2015", :from=> 'card_year'
      click_button "Subscribe"

      assert page.has_content?('Cancel subscription')
      click_link 'Cancel subscription'
      assert page.has_content?('Subscription cancelled.')
      assert page.has_content?('No active subscription.')
    end
  end
end
