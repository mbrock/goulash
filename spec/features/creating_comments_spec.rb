require 'spec_helper'

feature "Creating comments" do
  before do
    @post = FactoryGirl.create :post
    @commenter = FactoryGirl.create :user

    visit new_user_session_path
    fill_in 'Email', with: @commenter.email
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
  end

  scenario "Adding a comment" do
    visit post_path(@post)
    click_link 'Add comment'
    find('textarea').set '*Yay*'
    click_button 'Create Comment'

    expect(current_path).to eql(post_path(@post))
    expect(page).to have_css('article .comments div')

    within 'article .comments > div' do
      within 'span.author' do
        expect(page).to have_content(@commenter.email)
      end

      within 'div em' do
        expect(page).to have_content('Yay')
      end
    end
  end
end