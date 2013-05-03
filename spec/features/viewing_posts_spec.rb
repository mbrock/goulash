require 'spec_helper'

feature 'Viewing posts' do
  before do
    @user = FactoryGirl.create(:user, email: 'foo@example.com')

    @first_post = FactoryGirl.create(:post, title: 'First post',
      text: 'This is my first post.',
      user: @user)
    @second_post = FactoryGirl.create(:post, title: 'Second post',
      text: 'This is my second post.',
      user: @user)

    visit '/'
    click_link 'Sign in'
    fill_in 'Email', with: 'foo@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
  end

  scenario 'Listing all posts' do
    expect(page).to have_content('First post')
    expect(page).to have_content('Second post')
  end

  scenario "Viewing a post" do
    click_link 'First post'

    expect(page.current_url).to eql(post_url(@first_post))

    within('h2') do
      expect(page).to have_content('First post')
    end

    within('h3') do
      expect(page).to have_content('By foo@example.com')
    end

    expect(page).to have_content('This is my first post.')
  end

  scenario "Going back to index" do
    click_link 'First post'
    click_link 'Home'

    expect(page.current_url).to eql(root_url)
  end
end