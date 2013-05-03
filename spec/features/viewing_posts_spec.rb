require 'spec_helper'

feature 'Viewing posts' do
  before do
    @first_post = FactoryGirl.create(:post, title: 'First post',
      text: 'This is my first post.')
    @second_post = FactoryGirl.create(:post, title: 'Second post',
      text: 'This is my second post.')
    visit '/'
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

    expect(page).to have_content('This is my first post.')
  end
end