class PostsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all
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
    @text_html = RDiscount.new(@post.text).to_html
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
