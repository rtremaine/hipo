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

    click_link 'Sign out'
    assert page.has_content?('You need to sign in or sign up before continuing.')
    click_link 'Patients'
    assert page.has_content?('You need to sign in or sign up before continuing.')
    fill_in "user_email", :with => "thealey@gmail.com"
    fill_in "user_password", :with => "bondaxe"
    click_button "Sign in"
    assert page.has_content?('Signed in successfully.')

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
    p = { :first => 'Joe', :last => 'Smith' }
    click_link 'New Patient'
    fill_in 'patient_first', :with => p[:first]
    fill_in 'patient_last', :with => p[:last]
    click_button 'Create Patient'
    assert page.has_content?(p[:last])
    assert page.has_content?('Record Sets')
    
    click_button 'New Record Set'
    fill_in 'record_set_name', :with => xrays = 'X-Rays Auto Test'
    click_button 'Create'
    assert page.has_content?(xrays)
    click_link xrays
    assert page.has_content?(xrays)
    assert page.has_content?(p[:last])
    assert page.has_content?('You can drag files')
    assert page.has_content?('Sharing is disabled because')
    click_link 'Subscribe now'

    assert page.has_content?('New subscription')
    fill_in "name", :with=> 'Ted Healey'
    fill_in "card_number", :with=> '4242424242424242'
    fill_in "address_zip", :with=> '02043'
    fill_in "card_code", :with=> '123'
    select "January", :from=> 'card_month'
    select "2015", :from=> 'card_year'

    if (test_stripe = true)
      click_button "Subscribe"
      assert page.has_content?('Subscription was successfully created.')
      assert page.has_content?('Subscription is active')
      #assert page.has_content?((Time.now + 14.days).to_date.to_s(:long)) TODO no works for some reason
    else
      #TODO this is not working
      sub_size = Subscription.all.size
      assert Subscription.new(:user_id => u.id, :active =>true, :plan_id => 1).save!
      puts Subscription.all.size.to_s + ' : ' + sub_size.to_s
      assert Subscription.all.size > sub_size
      visit '/users/' + u.id.to_s
      assert page.has_content?('Subscription is active')
    end

    click_link 'Patients'
    click_link p[:last] + ', ' + p[:first]
    assert page.has_content?(p[:last])
    click_link xrays

    assert page.has_content?('Share with new contact')
    fill_in 'email', :with => (recipient = 'autotest@testauto.com')
    click_button 'Share'
    assert page.has_content?('Share was successfully created')
    assert page.has_content?(I18n.translate :sharing_records_called)

    s = Share.last
    assert !s.recipient.confirmed
    assert s.token

    assert page.has_content?(xrays)
    assert page.has_content?(recipient + ' is not a confirmed contact of yours')
    click_link 'Confirm and send email'
    assert page.has_content?('Record sharing email sent')
    click_link recipient
    assert page.has_content?('Record shares')
    assert page.has_content?('Received')
    assert page.has_content?('-')

    click_link 'Sign out'
    assert page.has_content?('You need to sign in or sign up before continuing.')

    visit '/users/sign_up'
    assert page.has_content?('Forgot your password?')
    fill_in "user_email", :with => recipient
    fill_in "user_password", :with => "bondaxe"
    fill_in "user_password_confirmation", :with => "bondaxe"
    click_button "Sign up"
    assert page.has_content?('Company name can\'t be blank')
    fill_in "user_email", :with => recipient
    fill_in "user_company_attributes_name", :with => "NewFirm"
    fill_in "user_password", :with => "bondaxe"
    fill_in "user_password_confirmation", :with => "bondaxe"
    click_button "Sign up"
    assert page.has_content?('Company name has already been taken')
    fill_in "user_email", :with => recipient
    fill_in "user_company_attributes_name", :with => "NewFirm2"
    fill_in "user_password", :with => "bondaxe"
    fill_in "user_password_confirmation", :with => "bondaxe"
    click_button "Sign up"

    assert page.has_content?('Welcome! You have signed up successfully.')
    assert page.has_content?(recipient)
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
