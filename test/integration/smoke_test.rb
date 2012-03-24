require 'integration_test_helper'

class SmokeTest < ActionController::IntegrationTest
  require 'capybara/rails'
  Capybara.default_driver = :selenium

  test 'sign up and subscribe' do
    visit '/users/sign_up'
    assert page.has_content?('Forgot your password?')
    fill_in "user_email", :with => "thealey@gmail.com"
    fill_in "user_password", :with => "bondaxe"
    fill_in "user_password_confirmation", :with => "bondaxe"
    click_button "Sign up"
    assert page.has_content?('Company name can\'t be blank')
    fill_in "user_email", :with => "thealey@gmail.com"
    fill_in "user_company_attributes_name", :with => "NewFirm"
    fill_in "user_password", :with => "bondaxe"
    fill_in "user_password_confirmation", :with => "bondaxe"
    click_button "Sign up"

    assert page.has_content?('Welcome! You have signed up successfully.')
    assert page.has_content?('thealey@gmail.com')
    u = User.find_by_email 'thealey@gmail.com'
    visit '/users/' + u.id.to_s
    assert page.has_content?('NewFirm')
    click_link 'NewFirm'
    assert page.has_content?('Staff')

    visit '/users/' + u.id.to_s
    assert page.has_content?('No active subscription')
    visit '/subscriptions'
    assert page.has_content?('You must be an administrator to access this section')
    visit '/patients'
    click_link 'MyString, MyString'
    assert page.has_content?('Record Sets')
    click_button 'New Record Set'
    fill_in 'record_set_name', :with => xrays = 'X-Rays Auto Test'
    click_button 'Create'
    assert page.has_content?(xrays)
    #click_link xrays
    #TODO: Not clickable in ajax div, only when refreshed
    #Plus should just go to the page I think. better.
  end

  test 'subscribe with stripe' do
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
