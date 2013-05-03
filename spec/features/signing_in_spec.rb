require 'spec_helper'

feature 'Signing in' do
  before do
    FactoryGirl.create(:user, email: 'foo@example.com')
  end

  scenario 'Signing in by form' do
    visit '/'
    click_link 'Sign in'
    fill_in 'Email', :with => 'foo@example.com'
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    page.should have_content("Signed in successfully.")
  end

  scenario 'Sign out' do
    visit '/'
    click_link 'Sign in'
    fill_in 'Email', :with => 'foo@example.com'
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'

    page.should_not have_link('Sign in')
    page.should_not have_link('Sign up')

    click_link 'Log out'
    page.should have_link('Sign in')
  end
end