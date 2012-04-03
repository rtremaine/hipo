require 'integration_test_helper'

class SmokeTest < ActionController::IntegrationTest
  require 'capybara/rails'

  def sign_out
    click_link 'Sign out'
    assert page.has_content?('You need to sign in or sign up before continuing.')
  end

  def subscribe
    assert page.has_content?('New subscription')
    fill_in "name", :with=> 'Ted Healey'
    fill_in "card_number", :with=> '4242424242424242'
    fill_in "address_zip", :with=> '02043'
    fill_in "card_code", :with=> '123'
    select "January", :from=> 'card_month'
    select "2015", :from=> 'card_year'
    click_button "Subscribe"
    sleep 20

    sleep 20 unless page.has_content?('Subscription was successfully created.')

    assert page.has_content?('Subscription was successfully created.')
    assert page.has_content?('Subscription is active')
  end

  def create_patient(first, last)
    visit '/patients'
    click_link 'New Patient'
    fill_in 'patient_first', :with => first
    fill_in 'patient_last', :with => last
    click_button 'Create Patient'
    assert page.has_content?(last)
    assert page.has_content?('Patient was successfully created.')
    assert page.has_content?('Record Sets')
  end

  def sign_up(email, company, password)
    visit '/users/sign_up'
    assert page.has_content?('Forgot your password?')
    fill_in "user_email", :with => email 
    fill_in "user_company_attributes_name", :with => company
    fill_in "user_password", :with => password
    fill_in "user_password_confirmation", :with => password
    click_button "Sign up"
  end

  def sign_in(email, password)
    visit '/users/sign_in'
    assert page.has_content?('Forgot your password?')
    fill_in "user_email", :with => email 
    fill_in "user_password", :with => password
    click_button "Sign in"
    assert page.has_content?('Signed in successfully.')
  end

  test 'sign up and subscribe' do
    Capybara.current_driver = :selenium
    sign_up('thealey@gmail.com', '', 'bondaxe')
    assert page.has_content?('Company name can\'t be blank')
    sign_up('thealey@gmail.com', 'NewFirm', 'bondaxe')
    assert page.has_content?('Welcome! You have signed up successfully.')
    assert page.has_content?('thealey@gmail.com')
    sign_out

    click_link 'Patients'
    assert page.has_content?('You need to sign in or sign up before continuing.')
    sign_in('thealey@gmail.com', 'bondaxe')

    u = User.find_by_email 'thealey@gmail.com'
    visit '/users/' + u.id.to_s
    assert page.has_content?('NewFirm')
    click_link 'NewFirm'
    assert page.has_content?('Staff')

    visit '/users/' + u.id.to_s
    assert page.has_content?('No active subscription')
    visit '/subscriptions'
    assert page.has_content?('You must be an administrator to access this section')

    p = { :first => 'Joe', :last => 'Smith' }
    create_patient(p[:first], p[:last]) 
    
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
    subscribe

    click_link 'Patients'
    click_link p[:last] + ', ' + p[:first]
    assert page.has_content?(p[:last])
    click_link xrays

    num_users = User.count
    assert page.has_content?('Share with new contact')
    fill_in 'email', :with => (recipient = '9@9.com')
    click_button 'Share'
    assert page.has_content?('Share was successfully created')
    assert User.count > num_users
    assert page.has_content?(I18n.translate :sharing_records_called)
    assert User.find_by_email(recipient)
    assert User.find_by_email(recipient).get_token

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

    sign_out

    token = User.find_by_email(recipient).get_token
    visit '/contacts?auth_token=' + token
    puts token
    assert page.has_content?(recipient)
    Capybara.use_default_driver
  end
end
