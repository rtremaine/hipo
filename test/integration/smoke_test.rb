require 'integration_test_helper'

class SmokeTest < ActionController::IntegrationTest
  require 'capybara/rails'
  test 'sign up' do
    visit '/users/sign_in'


    fill_in "user_email", :with=> "t@t.com"
    fill_in "user_password", :with=> "bondaxe"
    click_button "Sign in"
    print page.html
    assert page.has_content?('Signed in successfully.')

    click_link_or_button "Sign out"
    assert page.has_content?('You need to sign in')


    #visit '/uploads'
    #click_link_or_button 'New Upload'
    #fill_in 'upload_name', :with=>'sample upload'
    #attach_file "upload_upload", File.expand_path('../../fixtures/sample.jpg', __FILE__)
    #fill_in "upload_name", :with=>"sample rename"
  end
end
