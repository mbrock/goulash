require 'spec_helper'

feature "Creating posts" do
	scenario "Can create a post" do
    visit '/'

    click_link 'New post'

    fill_in 'Title', :with => 'My first post'
    fill_in 'Text', :with => 'Hello!'
    click_button 'Create Post'

    expect(page).to have_content('Thanks.')
  end
end