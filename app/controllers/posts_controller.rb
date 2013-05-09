class PostsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @post_groups = Post.grouped_by_day
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = 'Thanks.'
      redirect_to @post
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
