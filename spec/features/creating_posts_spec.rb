require 'spec_helper'

feature "Creating posts" do
  before do
    @user = FactoryGirl.create(:user, email: 'foo@example.com')

    @first_post = FactoryGirl.create(:post, title: 'First post',
      text: 'This is my first post.')
    @second_post = FactoryGirl.create(:post, title: 'Second post',
      text: 'This is my second post.')

    visit '/'
    click_link 'New post'
    page.should have_content('You need to sign in or sign up before continuing.')

    fill_in 'Email', with: 'foo@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    within('h2') do
      page.should have_content 'New post'
    end
  end

	scenario "Can create a post" do
    visit '/'

    click_link 'New post'

    fill_in 'Title', :with => 'My first post'
    fill_in 'Text', :with => 'Hello!'
    click_button 'Create Post'

    expect(page).to have_content('Thanks.')
  end
end