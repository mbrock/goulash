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
end