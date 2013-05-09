class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @comment.post
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :text)
  end
end
