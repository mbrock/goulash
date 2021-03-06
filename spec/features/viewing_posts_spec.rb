require 'spec_helper'

feature 'Viewing posts' do
  before do
    @user = FactoryGirl.create(:user, username: 'foo')

    @first_post = FactoryGirl.create(:post, 
      title: 'First post',
      text: 'This is my first post.',
      user: @user,
      created_at: Date.current)
    @second_post = FactoryGirl.create(:post, 
      title: 'Second post',
      text: 'This is my *second* post.',
      user: @user,
      created_at: Date.yesterday)

    visit '/'
    click_link 'Sign in'
    fill_in 'Username', with: @user.username
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
  end

  scenario 'Listing all posts' do
    expect(page).to have_content('First post')
    expect(page).to have_content('foo')
    expect(page).to have_content('Second post')
  end

  scenario 'Listing all posts should group by day' do
    within 'section.posts:nth-child(1)' do
      expect(page).to have_content('Today')
    end

    within 'section.posts:nth-child(2)' do
      expect(page).to have_content('Yesterday')
    end
  end

  scenario "Viewing a post" do
    click_link 'First post'

    expect(page.current_url).to eql(post_url(@first_post))

    within('h3') do
      expect(page).to have_content('First post')
      within('small') do
        expect(page).to have_content('By foo')
      end
    end

    expect(page).to have_content('This is my first post.')
  end

  scenario "Viewing a post with Markdown content" do
    click_link 'Second post'

    within "article > p > em" do
      expect(page).to have_content('second')
    end
  end

  scenario "Going back to index" do
    click_link 'First post'
    click_link 'Goulash'

    expect(page.current_url).to eql(root_url)
  end
end