require 'spec_helper'

describe PostsController do
  describe "GET index" do
    it "succeeds" do
      get :index
      response.should be_success
    end

    it "renders index" do
      get :index
      response.should render_template('posts/index')
    end

    it "loads posts" do
      Post.stub(:grouped_by_day) { 'post-groups' }
      get :index
      assigns(:post_groups).should eq('post-groups')
    end
  end

  describe "GET new" do
    it "redirects to login" do
      get :new
      response.should redirect_to(new_user_session_path)
    end

    it "succeeds when logged in" do
      sign_in FactoryGirl.create(:user)
      get :new
      response.should be_success
      response.should render_template('posts/new')
    end

    it "creates a new empty post" do
      sign_in FactoryGirl.create(:user)
      get :new
      assigns(:post).should be_a_new(Post)
    end
  end


  describe "POST create" do
    it "redirects to login" do
      post :create, FactoryGirl.attributes_for(:post)
      response.should redirect_to(new_user_session_path)
    end

    it "saves post" do
      sign_in FactoryGirl.create(:user)
      expect {
        post :create, post: FactoryGirl.attributes_for(:post)
      }.to change(Post, :count).by(1)
    end

    it "sets current user as author on new post" do
      user = FactoryGirl.create(:user)
      sign_in user
      post :create, post: FactoryGirl.attributes_for(:post)
      Post.last.user.should eq(user)
    end

    it "redirects to new post after saving" do
      sign_in FactoryGirl.create(:user)
      post :create, post: FactoryGirl.attributes_for(:post)
      response.should redirect_to(Post.last)
    end
  end

  describe "GET show" do
    it "succeeds with existing post" do
      post = FactoryGirl.create(:post)
      get :show, id: post.to_param
      assigns(:post).should eq(post)
      response.should be_success
    end
  end
end
