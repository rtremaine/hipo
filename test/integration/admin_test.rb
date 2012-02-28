require 'integration_test_helper'

class AdminTest < ActionController::IntegrationTest
  require 'capybara/rails'
  include Warden::Test::Helpers
  Warden.test_mode!

  setup do
    @user = users(:user)
  end

  test 'admin sign up and hit subscription page2' do
    if false
      visit '/users/sign_up'
      assert page.has_content?('Forgot your password?')
      fill_in "user_email", :with=> 'admin@g.com'
      fill_in "user_password", :with=> "bondaxe"
      fill_in "user_password_confirmation", :with=> "bondaxe"
      click_button "Sign up"
      assert page.has_content?('Welcome! You have signed up successfully.')
      assert page.has_content?('admin@g.com')
      admin = User.find_by_email('admin@g.com')
      admin.is_admin = true
      admin.save!
      visit '/subscriptions'
      assert page.has_content?('New Subscription')
      click_link "Sign out"
      assert page.has_content?('You need to sign in')
    end
  end

  test 'user sign up and hit subscription page' do
    visit '/users/sign_up'
    assert page.has_content?('Forgot your password?')
    fill_in "user_email", :with=> 'user@g.com'
    fill_in "user_password", :with=> "bondaxe"
    fill_in "user_password_confirmation", :with=> "bondaxe"
    click_button "Sign up"
    assert page.has_content?('Welcome! You have signed up successfully.')
    assert page.has_content?('user@g.com')
    visit '/subscriptions'
    #TODO: should put strings like this in i8n files
    assert page.has_content?('You must be an administrator to access this section')
    click_link "Sign out"
  end

end
