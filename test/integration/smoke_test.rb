require 'integration_test_helper'

class SmokeTest < ActionController::IntegrationTest
  require 'capybara/rails'
  Capybara.default_driver = :selenium

  test 'sign up' do
    visit '/users/sign_up'
    assert page.has_content?('Forgot your password?')
    fill_in "user_email", :with=> "thealey@gmail.com"
    fill_in "user_password", :with=> "bondaxe"
    fill_in "user_password_confirmation", :with=> "bondaxe"
    click_button "Sign up"
    assert page.has_content?('Welcome! You have signed up successfully.')
    assert page.has_content?('thealey@gmail.com')
    click_link_or_button "Sign out"
    assert page.has_content?('You need to sign in')

    visit '/users/sign_in'
    fill_in "user_email", :with=> "thealey@gmail.com"
    fill_in "user_password", :with=> "bondaxe"
    click_button "Sign in"
    assert page.has_content?('Signed in successfully.')

    visit '/subscriptions'
    assert page.has_content?('New Subscription')
    click_link 'New Subscription'
    fill_in "name", :with=> 'Moe Black'
    fill_in "address_zip", :with=> '02043'
    fill_in "card_number", :with=> '4242424242424242'
    select "January", :from=> 'card_month'
    select "2015", :from=> 'card_year'
    fill_in "card_code", :with=> '123'
    click_button "Subscribe"

    print page.html
    assert page.has_content?('Subscription is active')
    assert page.has_content?('99.00')

    visit '/users/3/'
    assert page.has_content?('Cancel subscription')
    click_link 'Cancel subscription'
    assert page.has_content?('Subscription cancelled.')
    assert page.has_content?('No active subscription.')
  end
end
