require 'spec_helper'

feature "Signing up" do
  scenario "Can't sign up without email" do
    visit '/'
    click_link 'Sign up'
    fill_in 'Username', :with => 'foo'
    find('#user_password').set('password')
    fill_in 'Password confirmation', :with => 'password'
    click_button 'Sign up'
    page.should have_content("1 error prohibited this user from being saved")
  end

  scenario 'Successful signup' do
    visit '/'
    click_link 'Sign up'
    fill_in 'Username', :with => 'foo'
    fill_in 'Email', :with => 'text@example.com'
    find('#user_password').set('password')
    fill_in 'Password confirmation', :with => 'password'
    click_button 'Sign up'
    page.should have_content("You have signed up successfully.")
  end
end