require 'spec_helper'

describe CommentsController do
  let(:the_post) { FactoryGirl.create :post }
  let(:the_user) { FactoryGirl.create :user }

  describe "GET new" do
    it "redirects to login" do
      get :new, post_id: the_post.id
      response.should redirect_to new_user_session_path
    end

    it "succeeds when signed in" do
      sign_in the_user
      get :new, post_id: the_post.id
      response.should be_success
      assigns(:post).should eq(the_post)
      assigns(:comment).should be_a_new(Comment)
    end
  end

  describe "POST create" do
    it "redirects to login" do
      post :create,
        post_id: the_post.id,
        comment: FactoryGirl.attributes_for(:comment)
      response.should redirect_to new_user_session_path
    end

    it "creates a comment and redirects to post" do
      sign_in the_user
      post :create,
        post_id: the_post.id,
        comment: FactoryGirl.attributes_for(:comment)
      response.should redirect_to the_post
    end
  end
end
