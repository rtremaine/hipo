require 'integration_test_helper'

class SmokeTest < ActionController::IntegrationTest
  require 'capybara/rails'
  Capybara.default_driver = :selenium

  test 'subscribe with stripe' do
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
